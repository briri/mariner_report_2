
# Redis must be runnning: redis-server
# Queue must be initialized: QUEUE=* rake environment resque:work

namespace :jobs do
  desc 'Scan or Sweep publisher feeds OR scrub expired articles'
  
  # -----------------------------------------------------------------------------
  task :scan, [:feed_id] => :environment do |t, args|
    logger = ActiveSupport::Logger.new('log/scanner.log')
    
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
  task sweep: :environment do
    logger = ActiveSupport::Logger.new('log/scanner.log')
    
    puts "Processing ... See log/scanner.log for more information"
        
    ScanAllFeedsJob.perform_now
  end
  
  # -----------------------------------------------------------------------------
  task scrub: :environment do
    puts "Processing ... See log/scrubber.log for more information"
    
    RemoveExpiredArticlesJob.perform_now
  end
  
  # -----------------------------------------------------------------------------
  task reset_pwd: [:password, :new_password] => :environment do
    puts "Resetting the password"
    
    if args.count == 2
      user = User.first
      if user.save(current_password: args[:password], password: args[:new_password], password_confirmation: args[:new_password])
        puts "success"
      else
        puts "unable to reset the password"
      end
    else
      puts "unable to perform your request"
    end
  end
end