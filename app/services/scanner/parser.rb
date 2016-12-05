require 'rss'
require 'open-uri'

module Scanner
  class Parser
    
    # -----------------------------------------------------------------
    def parse(content)
      RSS::Parser.parse(content)
    end
    
  end
end