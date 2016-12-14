require_relative 'scanner/helper.rb'

class ScannerService 
  
  include Scanner::Helper
  
  def initialize
  	@force_scan = Rails.env.development? ? true : false;
	
  	@max_words = Rails.configuration.jobs[:scanner][:articles][:max_word_count]
  end
  
  # ---------------------------------------------------------
  def scan(feed)
  	recorded = 0
  	now = Time.now
    today = Date.today
    scraper = Scanner::Scraper.new

    if feed.is_a?(Feed)
      publisher = feed.publisher
      
  	  # Only scan if the publisher is ready or we're in DEV
  	  if feed.next_scan_on <= now #|| Rails.environment == 'development'
        # Create and instance of the appropriate reader
        feed_type = (feed.feed_type.name.split('-').collect{|p| p.capitalize }.join(''))
        
        reader = "Scanner::#{feed_type}Reader".constantize.new
        
  		  articles = reader.read(publisher, feed)
          
				articles.each do |article|
          oldest = (today - feed.max_article_age_in_days)

          # If the article has not already expired
          if article.publication_date >= oldest

            sanitize_url(article.target, publisher)

            # Set the article's expiration date based on the feed's max_article_age_in_days
            article.expiration = article.publication_date + (feed.max_article_age_in_days * 24 * 60 * 60)

            article.categories << feed.categories
            
            podcast = Category.find_by(name: 'Podcast')
            
            # scrape the page to find additional information
            #
            # If this is a Podcast publisher and no media link was found in the RSS
            #       OR the article has less than 20 words and is not a video/audio
            #       OR the article has no thumbnail
            if (feed.categories.include?(podcast) && article.media.nil?) ||
                (word_count(article.content) < Rails.configuration.jobs[:scanner][:articles][:max_word_count] && article.media_type.nil?) || 
                article.thumbnail.nil?
          
              # If this isn't a custom feed for a particular hosttype
              unless ['youtube'].include?(feed.feed_type.name)
                scraped = scraper.scrape(feed.article_css_selector, article.target)
                
                unless scraped.nil?
                  # If the RSS content was too short, use the text from the page
                  if word_count(article.content) < 20
                    article.content = clean_html(strip_html(scraped))
                  end
              
                  scraped = escaped_to_html(scraped)
                
puts scraped
                
                  # Detect the media contents from the page
                  hash = detect_media_content(scraped)
                  
                  article.media_type = hash[:type] if article.media_type.nil?
                  article.media_host = hash[:host] if article.media_host.nil?
                  article.thumbnail = hash[:thumb] if article.thumbnail.nil?
                  article.media = hash[:media] if article.media.nil?
                end
              end
              
            end # if Podcast with no media OR content < 20 words and not a video/audio OR ...
          
            article.save!
            article.reload
          
            # Retrieve a thumbnail for the video content or if a thumbnail uri was found
            if article.media_type == 'video' || !article.thumbnail.nil?
              DownloadThumbnailJob.perform_now article.id
            end
          
            # If the article's publication date is greater than the one stored in the feed
            feed.last_article_from = article.publication_date if article.publication_date > feed.last_article_from
          
          end # publication date >= oldest
          
        end # articles.each
        
      end # Scan if next_scan_on <= now || development
      
      now = Time.now
      
      # Record the scan time and set the next scan time
      feed.last_scan_on = now
      feed.next_scan_on = now + (feed.scan_frequency_in_hours * 60 * 60)
      feed.save!
      
    else
      log.error "ScannerService.scan - was expecting a Feed! Got #{feed.class.name}"
    end
    
  end
  
  
  private 
    # Clean up the target url if necessary
    #   Add the http protocol and hope that the host forwards to https if necessary if it starts with '//'
    #   Assume that the image resides on the publisher's host if it starts with '/'
    # ---------------------------------------------------------------------------
    def sanitize_url(url, publisher)
      url = url.gsub(/'/, '')
      url = "http:#{url}" if url.start_with?('//')
      url = "#{publisher.homepage}#{url}" if url.start_with?('/')
      url
    end
    
end