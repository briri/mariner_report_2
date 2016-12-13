class ScanAllFeedsJob < ApplicationJob
  queue_as :default
  
  def perform()
    scanner = ScannerService.new
    start = Time.now
    
    puts "Scanning feeds #{now.to_s} - #{start}"
    
    Feed.where("active = ? AND next_scan_on <= ?", [true, start]).each do |feed|
      scanner.scan(feed)
    end
    
    stop = Time.now
    log.info "Scanning completed at #{stop} - #{(start - stop) / 1.minute} minutes"
    
    #after_enqueue
    
    #after_preform
  end
  
end