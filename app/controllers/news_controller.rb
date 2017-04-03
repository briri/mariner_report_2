class NewsController < ApplicationController
  
  # GET /
  # -------------------------------------------------------------------
  def index
    @featured = Article.featured.first
    
    watch = Article.watch
    listen = Article.listen
    read = Article.read
    racing = Article.racing

    @read = read.select{|a| (!watch.include?(a) && !listen.include?(a)) }[0..5]
    @racing = racing.select{|a| (!watch.include?(a) && !listen.include?(a)) }[0..5]
    @watch = watch[0..5]
    @listen = listen[0..5]
  end
  
  private
    # -------------------------------------------------------------------
    def get_recent_articles(categories, max_per_category, max_total)
      out = []
    
      cats = {}
    
      # Retrieve all of the articles associated with the categories
      rslts = Article.joins(:feed, :categories).where("feeds.featured = ? AND categories.slug IN (?)", false, categories).
                      order(publication_date: :desc)
    
      rslts.each do |article|
        if out.count < max_total
          add_it = false
      
          unless out.include?(article)
            article.categories.each do |category|
              cats[category.id] = (cats[category.id] ? cats[category.id] + 1 : 1)
        
              if cats[category.id] <= max_total && !article.thumbnail.blank?
                add_it = true
              end
            end
      
            out << article if add_it
          end
          
        else
          break
        end
      end
      
      out
    end
  
end