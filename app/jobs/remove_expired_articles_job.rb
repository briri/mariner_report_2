class RemoveExpiredArticlesJob < ApplicationJob
  queue_as :default
  
  Rails.logger = Logger.new("#{Rails.root}/log/remove_expired.log")
  
  def perform()
    scrubber = ScrubberService.new
    start = Time.now
    
    Rails.logger.info "Scrubbing expired articles - #{start}"
    
    scrubber.scrub_expired
    
    stop = Time.now
    Rails.logger.info "Scubbing completed at #{stop} - #{(start - stop) / 1.minute} minutes"
    
    #after_enqueue
    
    #after_preform
  end
  
end