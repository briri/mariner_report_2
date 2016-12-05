require 'net/http'

module Scanner
  class Reader
    
    # -------------------------------------------------------------------
    def read(publisher, feed)
      articles, counter = [], 0

      uri = URI(feed.source)
      
      response = self.fetch(uri, 0)
      
      if response.code.to_i == 200
        # Create an instance of the appropriate parser
        if feed.feed_type == 'youtube'
          parser = YoutubeParser.new
        else
          parser = Parser.new
        end
        
        parsed = parser.parse(response.body)
        
        unless parsed.nil?
          parsed.items.each do |entry|
            article = self.process(entry)
            
            article.publisher = publisher
            
            if article.valid?
              today = Date.today
              oldest = (today - feed.max_article_age_in_days)

              # If the article has not already expired
              if article.publication_date >= oldest

                # Clean up the target url if necessary
                #   Add the http protocol and hope that the host forwards to https if necessary if it starts with '//'
                #   Assume that the image resides on the publisher's host if it starts with '/'
                article.target = article.target.gsub(/'/, '')
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
                if (feed.categories.include?('Podcast') && article.media.nil?) ||
                    (word_count(article.content) < Rails.configuration.scanner[:scanner][:articles][:max_word_count] && !article.media_type.nil?)|| 
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
                end
            
                # Set the article's expiration date based on the feed's max_article_age_in_days
                article.expiration = article.publication_date + (feed.max_article_age_in_days * 24 * 60 * 60)

                articles << article
            
              end # Article too old?
                              
            else
              puts "Scanner::Read.read - Invalid Article: #{article.errors.collect{|e| e}.join(', ')}"
            end
            
          end # loop through parsed entries
        end # !parsed.nil?

      else
        puts "Scanner::Read.read - Publisher: #{publisher.slug}, Feed: #{feed.source} - #{response.code}: #{response.message}"
      end
      
      articles
    end
    
    # -------------------------------------------------------------------
    def process(entry)
      
    end
    
    protected
      # -------------------------------------------------------------------
      def fetch(uri, count)
        request = Net::HTTP::Get.new(uri)
        set_headers(request)
      
        response = Net::HTTP.start(uri.hostname, uri.port, 
                                    use_ssl: uri.scheme == 'https') do |http|
          http.request(request)
        end
    
        if response.is_a?(Net::HTTPRedirection) && count <= Rails.configuration.scanner[:scanner][:reader][:redirect_limit]
          self.fetch(URI.parse(response['location']), count + 1)
        
        else
          response
        end
      end
      
      # -------------------------------------------------------------------
      def set_headers(request)
        request['Accept'] = 'application/rss+xml'
        request['User-Agent'] = 'mariner-report'
      end
      
      # -------------------------------------------------------------------
      def word_count(content)
        content.split(' ').count
      end
      
      # -------------------------------------------------------------------
      def clean_html(content)
        content.gsub(/\s\s+/, ' ').
                gsub(/\\t/, '').
                gsub(/\\n/, '').
                gsub(/\\t/, '').
                gsub(/&#160;/, '').
                gsub(/&#39;/, "'").
                gsub(/&[lr]dquo;/, '"').
                gsub(/&[lr]squo;/, "'").
                gsub(/\[&#8230;\]/, '').
                gsub(/&#8230;/, '...').
                gsub(/&#8211;/, "-").
                gsub(/&#821[67];/, "'").
                gsub(/\\xe2\\x80\\x9[89]/, "'").
                gsub(/\\xe2\\x80\\x9[cd]/, '"').
                gsub(/\\xe2\\x80\\x93/, "-").
                gsub(/\\xe2\\x80\\x94/, "--").
                gsub(/\\xe2\\x80\\xa6/, "...")
      end
      
      # -------------------------------------------------------------------
      def strip_html(content)
        content.gsub(/<[^>]*>/, '')
      end
      
      # -------------------------------------------------------------------   
      def escaped_to_html(content)
        content.gsub(/&quot;/, '"').
                gsub(/&lt;/, '<').
                gsub(/&gt;/, '>').
                gsub(/&amp;/, '&')
      end
      
      # -------------------------------------------------------------------   
      def clean_author(author)
        auth = author.gsub(/@.*\.[a-z]+/, '')
        parts = auth.split('.')
  
        (parts[0].capitalize + (parts[1] ? (' ' + parts[1].capitalize) : ''))
      end
      
      # -------------------------------------------------------------------   
      def detect_category(tag)
        tag = strip_html(tag)
        category = Category.find_by(slug: tag.downcase.gsub(' ', '-'))
        
        if category.nil?
          category = UnknownTag.new(value: tag)
        end
        
        category
      end
      
      # -------------------------------------------------------------------   
      def detect_media_content(content)
        type, host, thumb, media = nil, nil, nil, nil
    
        img_matches = content.match(/<img.+?src=[\'"](.+?)[\'"].*?>/)
        aud_matches = content.match(/<audio.+?src=[\'"](.+?)[\'"].*?>/)
        vid_matches = content.match(/<video.+?src=[\'"](.+?)[\'"].*?>/)
        fra_matches = content.match(/<iframe.+?src=[\'"](.+?)[\'"].*?>/)

        source = Proc.new{ |text| text.match(/src=[\'"](.+?)[\'"]/)[0].
                                   gsub(/src=[\'"]/, "").gsub('"', '') }
  
        if aud_matches
          type = 'audio'
          media = source.call(aud_matches[0])
          host = (media ? URI.parse(media).hostname : null)
          host = (host ? host.gsub('www.', '') : null)
          thumb = source.call(img_matches[0])
  
        elsif vid_matches
          type = 'video'
          media = source.call(vid_matches[0])
          host = (media ? URI.parse(media).hostname : null)
          host = (host ? host.gsub('www.', '') : null)
          thumb = source.call(img_matches[0])
    
        elsif fra_matches
          media = source.call(fra_matches[0])
          media = (media.startsWith('//') ? 'http:' + media : media)
    
          if media.indexOf('html5-player.libsyn') >= 0
            media = media.gsub('/autoplay/yes/', '/autoplay/no/')
                         .gsub('/thumbnail/no/', '/thumbnail/yes/')
          end
    
          host = (media ? URI.parse(media).hostname : null)
          host = (host ? host.gsub('www.', '') : null)
          
          if img_matches
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
          
        elsif img_matches
          thumb = source.call(img_matches[0]);
        end
      
        {type: type, host: host, thumb: thumb, media: media}
      end
      
  end
end