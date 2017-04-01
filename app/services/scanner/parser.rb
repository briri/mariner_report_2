require 'rss'
require 'open-uri'

module Scanner
  class Parser
    
    # -----------------------------------------------------------------
    def parse(feed, content)
      begin
        RSS::Parser.parse(content)
        
      rescue Exception => e
        # Invalid itunes:duration for podcast - attempt to fix
        if e.message.include?('value <00> of tag <duration>') && @attempts.nil?
          Rails.logger.error "Scanner::Parser.parse - Attempting to correct issue and re-parse"
          
          @attempts = 1
          self.parse(content.gsub('<itunes:duration>00</itunes:duration>', 
                                  '<itunes:duration>01:00:00</itunes:duration>'))
        else
          msg = "Scanner::Parser.parse - Invalid RSS format : #{e}"
          Rails.logger.error msg
          Rails.logger.error content.inspect
          
          log_failure(feed, msg, 1)
          nil
        end
      end
    end
    
  end
end