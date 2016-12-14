class ScrubberService 
  
  def initialize

  end

  # ---------------------------------------------------------
  def scrub_expired()
    now = Time.now
    
    # Collect the expired articles and order them by their expiration date so that the
    # oldest are removed first
    Articles.where("expiration <= ?", now).order(expiration: :asc).each do |article|
      scrub_it = true
      
puts "EXPIRED: #{article.target}"
      
      # Make sure that the article doesn't bring one of its categories down to less than 10 articles!
      article.categories.each do |category|
        scrub_it = false if category.articles.count < 10
      end

      if scrub_it
        scrub(article)
        
      else
puts "Cannot scrub #{article.target}"
      end
    end
  
  end
  
  # ---------------------------------------------------------
  def scrub(article)
    if article
      unless article.thumbnail.nil?
        deleter = ThumbnailService.new
        deleter.delete(article.thumbnail)
      end
    
      article.destroy
    end
  end
  
end