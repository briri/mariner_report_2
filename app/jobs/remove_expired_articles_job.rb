class RemoveExpiredArticlesJob < ApplicationJob
  queue_as :default
  
  def perform()
    scanner = ScrubberService.new
    start = Time.now
    
    puts "Scrubbing expired articles #{now.to_s} - #{start}"
    
    scrubber.scrub
    
    stop = Time.now
    log.info "Scubbing completed at #{stop} - #{(start - stop) / 1.minute} minutes"
    
    #after_enqueue
    
    #after_preform
  end
  
end