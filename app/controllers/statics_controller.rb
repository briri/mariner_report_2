class StaticsController < ApplicationController
  
  # GET /explore
  # -------------------------------------------------------------------
  def explore
    @method = params[:method] ||= 'Categories'
    
    regional = CategoryType.find_by(name: 'Regional')
    
    # All Active NON Regional Categories
    if @method == 'Categories'
      @items = Category.active.where.not(category_type: regional).select{ |c| c.articles.count > 0 }.collect{ |p| 
        {title: p.name,
         thumbnail: "categories/#{(p.thumbnail.blank? ? 'default_category.png' : p.thumbnail)}",
         target: "/categories/#{p.slug}",
         article_count: p.articles.count} 
       }
    
    # All Active Regional Categories
    elsif @method == 'Regional'
      @items = Category.active.where(category_type: regional).select{ |c| c.articles.count > 0 }.collect{ |p| 
        {title: p.name,
         thumbnail: "categories/#{(p.thumbnail.blank? ? 'default_region.png' : p.thumbnail)}",
         target: "/categories/#{p.slug}",
         article_count: p.articles.count} 
       }
      
    # All Active Publishers
    else
      @items = Publisher.active.select{ |c| c.articles.count > 0 }.collect{ |p| 
        {title: p.name,
         thumbnail: "publishers/#{(p.thumbnail.blank? ? 'default_publisher.png' : p.thumbnail)}",
         target: "/publishers/#{p.slug}",
         article_count: p.articles.count} }
    end
  end
  
end