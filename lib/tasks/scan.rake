
# Redis must be runnning: redis-server
# Queue must be initialized: QUEUE=* rake environment resque:work

namespace :scanner do
  desc 'Scan publisher feeds'
  
  # -----------------------------------------------------------------------------
  task :scan, [:feed_id] => :environment do |t, args|
    log = ActiveSupport::Logger.new('log/scanner.log')
    
    # If a feed id was passed in then we will only scan that feed
    if args.count > 0
      feed = Feed.find(args[:feed_id].to_i)
      
      if feed.nil?
        log.info "Unknown feed! Please pass in the feed id."
        continue = false
      else
        puts "Processing ... See log/scanner.log for more information"
        ScanFeedJob.perform_now(feed)
      end
      
    # Otherwise we should scan all feeds that are active and whose next_scan_on has passed
    else
      puts "You must provide a feed id to run this process!"
    end
  end
  
  # -----------------------------------------------------------------------------
  task :sweep, :environment do
    log = ActiveSupport::Logger.new('log/scanner.log')
    
    puts "Processing ... See log/scanner.log for more information"
        
    ScanAllFeedsJob.perform_now
  end
end