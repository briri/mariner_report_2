
# Redis must be runnning: redis-server
# Queue must be initialized: QUEUE=* rake environment resque:work

namespace :scanner do
  desc 'Scan publisher feeds'
  
  # -----------------------------------------------------------------------------
  task :scan, [:feed_id] => :environment do |t, args|
    log = ActiveSupport::Logger.new('log/scanner.log')
    start, continue, feeds = Time.now, true, []
    
    puts "Processing ... See log/scanner.log for more information"
    
    # If a feed id was passed in then we will only scan that feed
    if args.count > 0
      feed = Feed.find(args[:feed_id].to_i)
      
      if feed.nil?
        log.info "Unknown feed! Please pass in the feed id."
        continue = false
      else
        feeds << feed
      end
      
    # Otherwise we should scan all feeds that are active and whose next_scan_on has passed
    else
      feeds = Feed.where("next_scan_on <= ? AND active: true", start.strftime("%Y-%m-%d %H:%M:%S"))
    end
    
    feeds.each do |feed|
      ScanFeedJob.perform_now(feed)
    end
  end
  
end