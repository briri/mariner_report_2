class NewsController < ApplicationController
  
  # GET /
  # -------------------------------------------------------------------
  def index
    @podcasts = get_recent_articles(['podcast'], 3, 6)

    @videos = get_recent_articles(['video'], 3, 6)
    
    interests = ['couples', 'families', 'gear', 'conservation', 'magazines', 
                 'maintenance', 'safety', 'solo', 'travel']
                 
    racing = ['race', 'vendee', 'volvo-ocean-race', 'women-in-racing', 'olympics',
              'clipper', 'americas-cup']
    
    @interests = get_recent_articles(interests, 3, 12)
    @racing = get_recent_articles(racing, 3, 12)
    
    @interests = @interests.select{|a| !@videos.include?(a) }[0..5]
    @racing = @racing.select{|a| !@videos.include?(a) }[0..5]
  end
  
  private
    # -------------------------------------------------------------------
    def get_recent_articles(categories, max_per_category, max_total)
      out = []
    
      cats = {}
    
      # Retrieve all of the articles associated with the categories
      rslts = Article.joins(:categories).where("categories.slug IN (?)", categories).
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