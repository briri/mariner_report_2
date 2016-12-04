require 'rss'
require 'open-uri'

module Scanner
  class Parser
    
    # -----------------------------------------------------------------
    def parse(uri)
      parsed = []
      
      open(uri) do |rss|
        feed = RSS::Parser.parse(rss)
        log.info "Retrieving Feed: #{uri} - Title: #{feed.channel.title} (#{feed.items.count} entries)"

        parsed = feed.items
      end
      
      parsed
    end
    
  end
end