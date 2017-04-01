class NewsController < ApplicationController
  
  # GET /
  # -------------------------------------------------------------------
  def index
    @featured = Article.joins(:feed).where('feeds.featured = ?', true).
                        order(publication_date: :desc).first
    
    medias = ['video', 'podcast']
                        
    interests = ['couples', 'families', 'gear', 'conservation', 'magazines', 
                 'maintenance', 'safety', 'solo', 'travel']

    racing = ['race', 'vendee', 'volvo-ocean-race', 'women-in-racing', 'olympics',
              'clipper', 'americas-cup'] 
    
    watch = Article.joins(:feed, :categories).
                  where("feeds.featured = ? AND categories.slug IN (?)", 
                  false, ['video']).order(publication_date: :desc)
                  
    listen = Article.joins(:feed, :categories).
                  where("feeds.featured = ? AND categories.slug IN (?)", 
                  false, ['podcast']).order(publication_date: :desc)
              
    interests = ['couples', 'families', 'gear', 'conservation', 'magazines', 
                 'maintenance', 'safety', 'solo', 'travel']
   
    racing = ['race', 'vendee', 'volvo-ocean-race', 'women-in-racing', 'olympics',
              'clipper', 'americas-cup']
              
    read = Article.joins(:feed, :categories).
                where("feeds.featured = ? AND categories.slug IN (?)", 
                false, interests).order(publication_date: :desc)
                  
    racing = Article.joins(:feed, :categories).
                where("feeds.featured = ? AND categories.slug IN (?)", 
                false, racing).order(publication_date: :desc)

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