require 'net/http'
require_relative 'helper.rb'

module Scanner
  class Reader
     
    include Scanner::Helper
     
    # -------------------------------------------------------------------
    def read(publisher, feed)
      articles, counter = [], 0

      uri = URI(feed.source)
      
      response = self.fetch(feed, uri, 0)
      
      if response.code.to_i == 200
        # Create an instance of the appropriate parser
        if feed.feed_type == FeedType.find_by(name: 'youtube')
          parser = YoutubeParser.new
        else
          parser = Parser.new
        end
        
        begin
        
          parsed = parser.parse(feed, response.body)
          unless parsed.nil?
            parsed.items.each do |item|
              unless item.nil?
              
                if parsed.feed_type == 'atom'
                  entry = {
                    content: (item.content.nil? ? nil : item.content.content),
                    date: (item.published.nil? ? nil : item.published.content),
                    author: (item.author.nil? ? nil : (item.author.name.nil? ? nil : item.author.name.content)),
                    title: (item.title.nil? ? nil : item.title.content),
                    link: nil,
                    subjects: []
                  }
              
                  link = item.links.select{ |l| l.rel == 'alternate' }.first
                  entry[:link] = link.href unless link.nil?
              
                  entry[:description] = entry[:content]
                  entry[:subjects] = item.categories.collect{ |c| c.term }

                elsif item.is_a?(Hash)
                  entry = {
                    content: (item[:content_encoded].nil? ? item[:description] : item[:content_encoded]),
                    description: item[:description],
                    date: item[:pubDate],
                    author: (item[:author].nil? ? item[:dc_creator].to_s : item[:author]),
                    title: item[:title],
                    link: item[:link],
                    subjects: []
                  }
              
                  if !item[:category].nil?
                    entry[:subjects] << item[:category].content unless item[:category].is_a?(Array)
                    entry[:subjects] = item[:category].collect{ |c| c.content } if item[:category].is_a?(Array)
              
                  elsif !item[:dc_subject].nil?
                    entry[:subjects] << item[:dc_subject].content unless item[:dc_subject].is_a?(Array)
                    entry[:subjects] = item[:dc_subject].collect{ |c| c.content } if item[:dc_subject].is_a?(Array)
                  end
                
                else
                  entry = {
                    content: (item.content_encoded.nil? ? item.description : item.content_encoded),
                    description: item.description,
                    date: item.pubDate,
                    author: (item.author.nil? ? item.dc_creator.to_s : item.author),
                    title: item.title,
                    link: item.link,
                    subjects: []
                  }
              
                  if !item.category.nil?
                    entry[:subjects] << item.category.content unless item.category.is_a?(Array)
                    entry[:subjects] = item.category.collect{ |c| c.content } if item.category.is_a?(Array)
              
                  elsif !item.dc_subject.nil?
                    entry[:subjects] << item.dc_subject.content unless item.dc_subject.is_a?(Array)
                    entry[:subjects] = item.dc_subject.collect{ |c| c.content } if item.dc_subject.is_a?(Array)
                  end
                end
            
                article = self.process(publisher, feed, entry)
            
  Rails.logger.debug "FINISHED READER.PROCESS (I'M A #{self.class.name}) : article_count #{articles.count}"

                if !article.nil?
                
                  article.feed = feed
                
                  if article.valid?
                  
                    # Check the RSS feed's content. If it contains an image/video there will be
                    # no need to scrape the page later
                    unless entry[:content].nil?
                      hash = detect_media_content(entry[:content])
              
                      #Rails.logger.debug "DETECTED #{hash}"
              
                      article.media_type = hash[:type] if article.media_type.nil?
                      article.media_host = hash[:host] if article.media_host.nil?
                      article.thumbnail = hash[:thumb] if article.thumbnail.nil?
                      article.media = hash[:media] if article.media.nil?
                    end
                  
                    articles << article

                  else
                    unless article.errors.include?(:target)
                      msg = "Scanner::Read.read - Invalid Article: #{article.errors.full_messages.inspect}"
                      Rails.logger.error msg
                    
  #                    log_failure(feed, msg, 1)
                    end
                  end
            
                else
                  msg = "Scanner::Reader.read - Unable to generate article for #{publisher.slug} - #{feed.source} : #{entry[:link]}"
                  Rails.logger.warn msg
                  Rails.logger.warn entry.inspect
                
  #                log_failure(feed, msg, 1)
                end
              
              end # item.nil?
            
            end # loop through parsed entries
        
          else
            msg = "Scanner::Reader.read - Publisher: #{publisher.slug}, Feed: #{feed.source} : Unable to parse feed"
            Rails.logger.error msg
          
  #          log_failure(feed, msg, 1)
          end # !parsed.nil?

        rescue => e
          msg = "Scanner::Reader.read - Fatal error Publisher: #{publisher.slug}, Feed: #{feed.source} - #{e}"
          Rails.logger.error msg
          
        end

      else
        msg = "Scanner::Read.read - Publisher: #{publisher.slug}, Feed: #{feed.source} - #{response.code}: #{response.message}"
        Rails.logger.error msg
        
#        log_failure(feed, msg, 1)
      end
      
      articles
    end
    
    # -------------------------------------------------------------------
    def process(entry)
      
    end
    
    protected
      # -------------------------------------------------------------------
      def fetch(feed, uri, count)
        request = Net::HTTP::Get.new(uri)
        set_headers(request)
      
        begin
          response = Net::HTTP.start(uri.hostname, uri.port, read_timeout: 500,
                                      use_ssl: uri.scheme == 'https') do |http|
            http.request(request)
          end
    
          if response.is_a?(Net::HTTPRedirection) && count <= Rails.configuration.jobs[:scanner][:reader][:redirect_limit]
            self.fetch(feed, URI.parse(response['location']), count + 1)
        
          else
            response
          end
          
        rescue Exception => e
          msg = "Scanner::Reader.fetch - uri: #{uri} : #{e}"
          Rails.logger.error "Scanner::Reader.fetch - uri: #{uri} : #{e}"
          
          log_failure(feed, msg, 1)
          
          Net::HTTPResponse.new("", 500, "Unable to connect to feed address")
        end
      end
      
      # -------------------------------------------------------------------
      def set_headers(request)
        request['Accept'] = 'application/rss+xml'
        request['User-Agent'] = 'mariner-report'
      end
      
  end
end