require 'nokogiri'

module Scanner
  class Scraper
   
    def scrape(selector, uri)
      doc = Nokogiri::HTML(open(uri))
      
      content = doc.css(selector)[0]
      
      puts "Scraping: #{content.inspect}"
      
    end
    
  end
end