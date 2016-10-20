class StaticsController < ApplicationController
  
  # GET /explore
  # -------------------------------------------------------------------
  def explore
    @method = params[:method] ||= 'Categories'
    
    regional = CategoryType.find_by(name: 'Regional')
    
    # All Active NON Regional Categories
    if @method == 'Categories'
      @items = Category.active.where.not(category_type: regional).collect{ |p| 
        {title: p.name,
         thumbnail: p.thumbnail ||= '/images/default_category.png',
         target: "/categories/#{p.slug}",
         article_count: p.articles.count} 
       }
    
    # All Active Regional Categories
    elsif @method == 'Regional'
      @items = Category.active.where(category_type: regional).collect{ |p| 
        {title: p.name,
         thumbnail: p.thumbnail ||= '/images/default_region.png',
         target: "/categories/#{p.slug}",
         article_count: p.articles.count} 
       }
      
    # All Active Publishers
    else
      @items = Publisher.active.collect{ |p| 
        {title: p.name,
         thumbnail: p.thumbnail ||= '/images/default_publisher.png',
         target: "/publishers/#{p.slug}",
         article_count: p.articles.count} }
    end
  end
  
end