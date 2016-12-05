class ScannerService 
  
  def initialize
  	@force_scan = Rails.env.development? ? true : false;
	
  	@max_words = Rails.configuration.scanner[:scanner][:articles][:max_word_count]
  end
  
  # ---------------------------------------------------------
  def scan(feed)
  	recorded = 0
  	now = Time.now

    if feed.is_a?(Feed)
      publisher = feed.publisher
      
  	  # Only scan if the publisher is ready or we're in DEV
  	  if feed.next_scan_on <= now || Rails.environment == 'development'
        # Create and instance of the appropriate reader
        feed_type = (feed.feed_type.name.split('-').collect{|p| p.capitalize }.join(''))
        
        reader = "Scanner::#{feed_type}Reader".constantize.new
        
  		  reader.read(publisher, feed) do |articles|
  				articles.each do |article|
            
log.info "ARTICLE: #{article.inspect}"
            
            unless article.nil?
              
              if article.valid? 
                
              end
              
            end
          end
        end
        
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
end