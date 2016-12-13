require 'nokogiri'

module Scanner
  class Scraper
   
    def scrape(selector, uri)
      doc = Nokogiri::HTML(open(uri)) do |config|
        config.noblanks.nonet
      end
      
      selector = 'article' if selector.nil?
      
      content = doc.css(selector).first
      
      # Remove any markup that causes problems (e.g. <script>, <nav>, <img id="facebook">, etc.)
      Rails.configuration.jobs[:scanner][:scraper][:tags_to_ignore].each do |selector|
        content.search(selector).remove
      end
      
      content.to_s
    end
    
  end
end