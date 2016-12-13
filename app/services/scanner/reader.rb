require 'net/http'
require_relative 'helper.rb'

module Scanner
  class Reader
     
    include Scanner::Helper
     
    # -------------------------------------------------------------------
    def read(publisher, feed)
      articles, counter = [], 0

      uri = URI(feed.source)
      
      response = self.fetch(uri, 0)
      
      if response.code.to_i == 200
        # Create an instance of the appropriate parser
        if feed.feed_type == FeedType.find_by(name: 'youtube')
          parser = YoutubeParser.new
        else
          parser = Parser.new
        end
        
        parsed = parser.parse(response.body)
        
        unless parsed.nil?
          parsed.items.each do |entry|
            article = self.process(publisher, entry)
            
            if article.valid?
              articles << article

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
      
        begin
          response = Net::HTTP.start(uri.hostname, uri.port, 
                                      use_ssl: uri.scheme == 'https') do |http|
            http.request(request)
          end
    
          if response.is_a?(Net::HTTPRedirection) && count <= Rails.configuration.jobs[:scanner][:reader][:redirect_limit]
            self.fetch(URI.parse(response['location']), count + 1)
        
          else
            response
          end
          
        rescue Exception => e
          puts "Scanner::Reader.fetch - uri: #{uri} : #{e}"
          
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