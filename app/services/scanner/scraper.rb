require 'nokogiri'
require_relative 'helper.rb'

module Scanner
  class Scraper
   
   include Scanner::Helper
   
   def scrape(feed, selector, uri, redirects = 0)
     begin
       doc = Nokogiri::HTML(open(uri)) do |config|
         config.noblanks.nonet
       end
      
       selector = 'article' if selector.nil?
      
       content = doc.css(selector).first
      
       if !content.nil?
         # Remove any markup that causes problems (e.g. <script>, <nav>, <img id="facebook">, etc.)
         Rails.configuration.jobs[:scanner][:scraper][:tags_to_ignore].each do |selector|
           content.search(selector).remove
         end
        
       else
         msg = "Scanner::Scraper.scrape - Found no '#{selector}' in the content of #{uri}"
         Rails.logger.warn msg
         
         log_failure(feed, msg, 1)
       end
      
       content.to_s
        
     rescue Exception => e
       # OpenURI does not follow redirects automatically so we need to instruct it to call the new URI
       if redirects < 3 && e.to_s.include?('redirection')
        self.scrape(feed, selector, get_uris(e.to_s).select{ |u| u != uri }.first, redirects + 1) 
        
       else
         msg = "Scanner::Scraper.scrape - Scraping #{uri} : #{e.class.name} #{e}"
         Rails.logger.error msg
         
         log_failure(feed, msg, 1)
         nil
       end
     end
    end
    
  end
end