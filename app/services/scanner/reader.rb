require 'net/http'

module Scanner
  class Reader
    
    # -------------------------------------------------------------------
    def self.read(publisher, feed)
			articles, counter = [], 0

      uri = URI(feed)
      
      response = fetch(uri, request, 0)
      
      if response.code == 200
        # Create an instance of the appropriate parser
        feed_type = (feed.feed_type == 'youtube' ? 'Youtube' : 'Generic')
        
        parser = "Scanner::Parser::#{feed_type}".constantize
        
        parser.parse do |parsed|
          parsed.entries.each do |entry|
            
            self.process(entry) do |article|
              
              if article.valid?
                today = Date.today
                oldest = (today - feed.max_article_age_in_days)

								# If the article has not already expired
								if Date.parse(article.publication_date) >= oldest

									# Clean up the target url if necessary
                  #   Add the http protocol and hope that the host forwards to https if necessary if it starts with '//'
                  #   Assume that the image resides on the publisher's host if it starts with '/'
									article.target = article.target.replace(/'/g, '')
                  article.target = "http:#{article.target}" if article.target.start_with?('//')
                  article.target = "#{publisher.homepage}#{article.target}" if article.target.start_with?('/')

									# scrape the page to find additional information
                  #
                  # If this is a Podcast publisher and no media link was found in the RSS
                  #
									# OR the article has less than 20 words and is not a video/audio
                  #
									# OR the article has no thumbnail
                  podcast = Category.find_by(name: 'Podcast')
                  if (publisher.categories.include?('Podcast') && article.media.nil?) ||
											(word_count(article.content) < Rails.configuration.scanner[:scanner][:article][:max_word_count] && !article.media_type.nil?)|| 
											article.thumbnail.nil?
									
										# If this isn't a custom feed for a particular hosttype
										if ['youtube'].include?(feed.feed_type.name) < 0
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
                  end
                  
                  articles << article
                  
                end # Article too old?
                                    
              else
                log.error "Scanner::Read.read - Invalid Article: #{article.errors.collect{|e| e}.join(', ')}"
              end
              
            end # process()
            
          end # loop through parsed entries
        end # parser.parse()
        
      else
        log.error "Scanner::Read.read - Publisher: #{publisher.slug}, Feed: #{feed.source} - #{response.code}: #{response.message}"
      end
      
      articles
    end
    
    # -------------------------------------------------------------------
    def process(entry)
      
    end
    
    
    protected
      # -------------------------------------------------------------------
      def set_headers(request)
        request['Accept'] = 'application/rss+xml'
        request['User-Agent'] = 'mariner-report'
      end
      
      # -------------------------------------------------------------------
      def fetch(uri, count)
        request = Net::HTTP::Get.new(uri)
        set_headers(request)
        
        response = Net::HTTP.start(uri.hostname, uri.port, 
                                    use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end
      
        if response.is_a?(Net::HTTPRedirection) && count <= Rails.configuration.scanner[:scanner][:reader][:redirect_limit]
          follow_redirects(URI.parse(response['location']), count + 1)
          
        else
          response
        end
      end
      
      # -------------------------------------------------------------------
      def word_count(content)
        content.split(' ').count
      end
      
      # -------------------------------------------------------------------
      def clean_html(content)
        content.trim.replace(/\s\s+/g, ' ').
      							 replace(/\\t/g, '').
      							 replace(/\\n/g, '').
      							 replace(/\\t/g, '').
      							 replace(/&#160;/g, '').
      							 replace(/&#39;/g, "'").
  									 replace(/&[lr]dquo;/g, '"').
  									 replace(/&[lr]squo;/g, "'").
  									 replace(/\[&#8230;\]/g, '').
  									 replace(/&#8230;/g, '...').
  									 replace(/&#8211;/g, "-").
  									 replace(/&#821[67];/g, "'").
  									 replace(/\\xe2\\x80\\x9[89]/g, "'").
  									 replace(/\\xe2\\x80\\x9[cd]/g, '"').
  									 replace(/\\xe2\\x80\\x93/g, "-").
  									 replace(/\\xe2\\x80\\x94/g, "--").
  									 replace(/\\xe2\\x80\\xa6/g, "...")
      end
      
      # -------------------------------------------------------------------
      def strip_html(content)
        content.replace(/<[^>]*>/g, '')
      end
      
      # -------------------------------------------------------------------   
      def escaped_to_html(content)
        content.replace(/&quot;/g, '"').
        				replace(/&lt;/g, '<').
        				replace(/&gt;/g, '>').
        				replace(/&amp;/g, '&')
      end
      
      # -------------------------------------------------------------------   
      def clean_author(author)
      	auth = author.replace(/@.*\.[a-z]+/i, '')
      	parts = auth.split('.')
	
      	(parts[0].capitalize + (parts[1] ? (' ' + parts[1].capitalize) : '')
      end
      
      # -------------------------------------------------------------------   
      def detect_media_content(content)
      	type, host, thumb, media = nil, nil, nil, nil
		
      	img_matches = content.match(/<img.+?src=[\'"](.+?)[\'"].*?>/i)
      	aud_matches = content.match(/<audio.+?src=[\'"](.+?)[\'"].*?>/i)
      	id_matches = content.match(/<video.+?src=[\'"](.+?)[\'"].*?>/i)
      	fra_matches = content.match(/<iframe.+?src=[\'"](.+?)[\'"].*?>/i)

        source = Proc.new{ |text| text.match(/src=[\'"](.+?)[\'"]/i)[0].
                                   replace(/src=[\'"]/, "").replace('"', '') }
	
      	if aud_matches[0]
      		type = 'audio'
      		media = source.call(aud_matches[0])
      		host = (media ? URI.parse(media).hostname : null)
      		host = (host ? host.replace('www.', '') : null)
      		thumb = source.call(img_matches[0])
	
        elsif vid_matches[0]
      		type = 'video'
      		media = source.call(vid_matches[0])
      		host = (media ? URI.parse(media).hostname : null)
      		host = (host ? host.replace('www.', '') : null)
      		thumb = source.call(img_matches[0])
		
      	elsif fra_matches[0]
      		media = source.call(fra_matches[0])
      		media = (media.startsWith('//') ? 'http:' + media : media)
		
      		if media.indexOf('html5-player.libsyn') >= 0
      			media = media.replace('/autoplay/yes/', '/autoplay/no/')
      									 .replace('/thumbnail/no/', '/thumbnail/yes/')
          end
		
      		host = (media ? URI.parse(media).hostname : null)
      		host = (host ? host.replace('www.', '') : null)
          
      		if img_matches[0]
      			thumb = source.call(img_matches[0])
          end
		
          # If the content is not from an approved host Null it out
          if Rails.configuration.scanner[:scanner][:article][:valid_video_hosts].include?(host)
            type = 'video'
          elsif Rails.configuration.scanner[:scanner][:article][:valid_audio_hosts].include?(host)
            type = 'audio'
          else
            type, media, host = nil, nil, nil
          end
          
        elsif img_matches[0]
		      thumb = source.call(img_matches[0]);
      	}
      
        {type: type, host: host, thumb: thumb, media: media}
      end
      
  end
end