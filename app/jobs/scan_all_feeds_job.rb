class ScanAllFeedsJob < ApplicationJob
  queue_as :default
  
  Rails.logger = Logger.new("#{Rails.root}/log/scan_all.log")
  
  def perform()
    scanner = ScannerService.new
    start = Time.now
    
    Rails.logger.info "Scanning feeds - #{start}"
    
    Feed.where("active = ? AND next_scan_on <= ?", true, start).each do |feed|
      scanner.scan(feed)
    end
    
    stop = Time.now
    Rails.logger.info "Scanning completed at #{stop} - #{(start - stop) / 1.minute} minutes"
    
    #after_enqueue
    
    #after_preform
  end
  
end