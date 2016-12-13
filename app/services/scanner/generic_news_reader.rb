module Scanner
  class GenericNewsReader < RssReader
    
    # -------------------------------------------------------------------
    def process(publisher, entry)
      article = super
      potential = 0
      
      Rails.configuration.jobs[:scanner][:reader][:generic_news_feed_filters].each do |keyword|
        potential += 5 if article.title.include?(keyword)
        
        article.content.split(' ').each do |word|
          potential += 1 if word.downcase == keyword.downcase
        end
      end
      
      if potential >= 7
        article
        
      else
        puts "Scanner::GenericNewsReader - #{article.target} : Is not a sailing article"
        Article.new
      end
    end
    
  end
end  