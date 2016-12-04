class ScanFeedJob < ApplicationJob
  queue_as :default
  
  def scan(feeds)
    scanner = ScannerService.new
    
    scanner.scan(feeds.is_a?(Array) ? feeds : [feeds])
    
    #after_enqueue
    
    #after_preform
    
    rescue_from(Exception) do |exception|
      log.error "Scanner - #{exception}"
    end
  end
  
end