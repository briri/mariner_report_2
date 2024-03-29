require_relative 'helper.rb'
require 'rss'
require 'open-uri'

module Scanner
  class Parser
    
    # -----------------------------------------------------------------
    def parse(feed, content)
      begin
        # Attempt to fix invalid iTunes podcast duration - 59north
        content = content.gsub('<itunes:duration>00</itunes:duration>', 
                               '<itunes:duration>01:00:00</itunes:duration>')
        
        RSS::Parser.parse(content)
        
      rescue Exception => e
        msg = "Scanner::Parser.parse - Invalid RSS format : #{e}"
        Rails.logger.error msg
        Rails.logger.error content.inspect
        
        return nil
      end
    end
    
  end
end