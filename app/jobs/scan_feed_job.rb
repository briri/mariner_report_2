class ScanFeedJob < ApplicationJob
  queue_as :default
  
  def perform(feed)
    scanner = ScannerService.new
    
    scanner.scan(feed)
    
    #after_enqueue
    
    #after_preform
  end
  
end