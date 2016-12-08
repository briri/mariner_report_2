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
  	  if feed.next_scan_on <= now || Rails.environment == 'development'
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

            # Retrieve a thumbnail for the video content
            if article.media_type == 'video'
              article = retrieve_thumbnail_for_video(article)
            end
            
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
              if ['youtube'].include?(feed.feed_type.name)
                scraper.scrape(feed.article_css_selector, article.target) do |scraped| 
                  unless scraped.nil?
                    # If the RSS content was too short, use the text from the page
                    if word_count(article.content) < 20
                      article.content = clean_html(strip_html(scraped))
                    end
                
                    scraped = escaped_to_html(scraped)
                  
                    # Detect the media contents from the page
                    detect_media_content(scraped) do |hash|
                      article.media_type = hash[:type] if article.media_type.nil?
                      article.media_host = hash[:host] if article.media_host.nil?
                      article.thumbnail = hash[:thumb] if article.thumbnail.nil?
                      article.media = hash[:media] if article.media.nil?
                    end
                  end
                end
              end
              
            end # if Podcast with no media OR content < 20 words and not a video/audio OR ...
          
            article.save!
            article.reload
          
puts "ARTICLE: #{article.inspect}"
          
            # If a thumbnail was found then download it in a separate job
            unless article.thumbnail.nil?
              DownloadThumbnailJob.perform_now article.id
            end
            
          end # publication date >= oldest
          
        end # articles.each
        
      end # Scan if next_scan_on <= now || development
      
    else
      log.error "ScannerService.scan - was expecting a Feed! Got #{feed.class.name}"
    end
    
                
                
=begin
  						DB.wasScanned(article.id, function(truth){
  							if(!truth || CONFIG['server']['environment'] === 'DEV'){
  								var done = false;
				
  								// Setup the publisher specific items 
  								if(article.publication_date){
  									article.expiration = helper.formatDate(helper.addDays(article.publication_date, 
  																								publisher.max_article_age_in_days));
  								}
  								article.publisher_id = publisher.publisher_id;
  								article.publisher_name = publisher.name;
					
  								self._retrievePublisherCategories(publisher, function(categories){
  									article.categories = article.categories.concat(categories);
						
  									// If the article link has a relative path add the hostname
  									if(article.id.charAt(0) === '/'){
  										article.id = helper.fixHttpTarget(publisher.home, article.id);
  									}

  									// If the article has not already expired
  									if(article.expiration >= now){
					
  										// If the article's title isn't one we should ignore
  										var ignore = publisher.titles_to_ignore.find(function(title){
  											return article.title.indexOf(title) >= 0; 
  										});

  										if(ignore === undefined){
  											self._processMediaTypes(article, function(article){
								
  												if(article.thumbnail){
  													// Clean up the thumbnail url if necessary
  													if(article.thumbnail){
  														article.thumbnail = article.thumbnail.replace(/'/g, '');
										
  														if(article.thumbnail.startsWith('//')){
  															// Add the http protocol and hope that the host forwards to 
  															// https if necessary
  															article.thumbnail = 'http:' + article.thumbnail;
										
  														}else if(article.thumbnail.startsWith('/')){
  															// Assume that the image resides on the publisher's host
  															article.thumbnail = publisher.home + article.thumbnail;
  														}
  													}
									
  													setTimeout(function(){
  														downloader.downloadImage(article.thumbnail, function(file){
  															if(file){
  																article.thumbnail = file;
  															}
												
  															done = true;
  														});
									
  													}, ((1000 * delay) > 15000 ? 15000 : 1000 * delay));
								
  													delay++;
									
  												}else{
  													if(publisher.logo){
  														article.thumbnail = publisher.logo;
  													}
  													done = true;
  												}
								
  												//done = true;
  											});
						
  										}else{
  											done = true;
  										}
				
  									}else{
  										done = true;
  									}
  								});
							
  								var parse_waiter = setInterval(function(){
  									if(done){
  										clearInterval(parse_waiter);
						
  										self.emit('scanned', article.id);
						
  										// If the article has not already expired
  										if(article.expiration >= now){
					
  											// If the article's title isn't one we should ignore
  											var ignore = publisher.titles_to_ignore.find(function(title){
  												return article.title.indexOf(title) >= 0; 
  											});

  											if(ignore === undefined){
  												// parcel articles into tier one categories (e.g. Racing, Blogs)
  												var categories_found = self._idsToCategories(article.categories);
  												self._detectCategories(self._categories_tier1, article, categories_found, 
  													function(cat1){

  														self._detectCategories(self._categories_tier2, cat1, categories_found, 
  															function(cat2){

  																// If the article has categories
  																if(article.categories.length > 0){
						
  																	self.emit('categorized', article);
  																	recorded++;
  																	cntr++;
  																}
  															}
  														);
  													}
  												);
							
  											}else{
  												cntr++;
  											}
  										}else{
  											cntr++;
  										}
  									}
  								});
						
  							}else{
  								cntr++;
  							}
  						});
					
  					}else{
  						cntr++;
  					}
  				});

  				var article_waiter = setInterval(function(){
  					if(cntr >= articles.length){
  						clearInterval(article_waiter);

  						// Update the last scan date/time on the publisher and propogate to 
  						// the cache unless we're in DEV mode
  						publisher.last_scan = now;
  						if(recorded > 0){
  							publisher.last_article = now;
  						}
		
  						DB.savePublisher(publisher, function(){
  							callback();
  						});
			
  					}
  				}, 100);
  			});
	
  		});
		
  	}else{
  		callback();
  	}
=end
    
  end
  
  
  private
  
    # ---------------------------------------------------------------------------
    def retrieve_thumbnail_for_video(article)
      uri = URI.parse(article.target)
      
      if article.media_host.include?('youtu')
        # Generate the URL of the Youtube thumbnail
        vid_id = uri.path.gsub('/embed/', '').gsub(/\?.*/, '')
      
        article.thumbnail = "http://i.ytimg.com/vi/#{vid_id}/hqdefault.jpg"
        article.media = "#{article.target}?autoplay=1&rel=0"
      
      elsif article.media_host.include?('vimeo')
        # Call the vimeo API to get the location of the thumbnail
        target = URI.parse("https://vimeo.com/api/oembed.json?url=#{article.target}")

        opts = {url: target, }
        
        request = Net::HTTP::Get.new(target)
        request['Accept'] = 'application/json'
        request['User-Agent'] = 'request'
    
        response = Net::HTTP.start(target.hostname, target.port, 
                                    use_ssl: target.scheme == 'https') do |http|
          http.request(request)
        end
  
        json = JSON.parse(response.body)
  
        article.thumbnail = (json['thumbnail_url'] ? json['thumbnail_url'] : nil)        
      end
      
      article.thumbnail = sanitize_url(article.thumbnail, article.publisher) unless article.thumbnail.nil?

      article
    end
   
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