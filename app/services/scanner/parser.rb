require 'rss'
require 'open-uri'

module Scanner
  class Parser
    
    # -----------------------------------------------------------------
    def parse(content)
      begin
        RSS::Parser.parse(content)
        
      rescue Exception => e
        Rails.logger.error "Scanner::Parser.parse - Invalid RSS format : #{e}"
        nil
      end
    end
    
  end
end