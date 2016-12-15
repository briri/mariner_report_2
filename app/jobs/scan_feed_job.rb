class ScanFeedJob < ApplicationJob
  queue_as :default
  
  Rails.logger = Logger.new("#{Rails.root}/log/scan.log")
  
  def perform(feed)
    scanner = ScannerService.new
    
    start = Time.now
    
    Rails.logger.info "Scanning feed: #{feed.source} - #{start}"
    
    scanner.scan(feed)
    
    stop = Time.now
    Rails.logger.info "Scanning for #{feed.source} completed at #{stop} - #{(start - stop) / 1.minute} minutes"
    
    #after_enqueue
    
    #after_preform
  end
  
end