require 'nokogiri'
require 'ostruct'

module Scanner
  class YoutubeParser
    
    # -----------------------------------------------------------------
    def parse(feed, content)
      result = Nokogiri::XML(content)
      
      OpenStruct.new({
        items: result.css("entry").collect{ |e| 
          {title: e.css("title")[0].to_s,
           link: e.css("link")[0]['href'].to_s.gsub('http:', 'https:'),
           author: e.css("author name")[0].to_s,
           date: e.css("published")[0].to_s
          }
        }
      })
    end
    
  end
end
