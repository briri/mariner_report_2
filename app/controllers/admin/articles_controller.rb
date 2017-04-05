module Admin
  class ArticlesController < ApplicationController
  
    before_action { is_authorized?('edit_publishers') }
    
    # GET /admin/publishers/[:publisher_id]/feeds/[:feed_id]/articles/[:id]
    # ----------------------------------------------------
    def edit
      @categories = Category.order(:name)
      @article = Article.find_by(id: params[:id])
    end
    
    # PUT /admin/publishers/[:publisher_id]/feeds/[:feed_id]/articles/[:id]
    # ----------------------------------------------------
    def update
      @categories = Category.order(:name)
      @article = Article.find_by(id: params[:id])
    
      attrs = article_params
    
      cats = []
      attrs[:categories].each do |cat|
        cats << Category.find(cat) unless cat.empty?
      end
      attrs[:categories] = cats
    
      download_thumbnail = (@article.thumbnail != attrs[:thumbnail])
    
      if @article.update(attrs)
        DownloadThumbnailJob.perform_now(@article.id) if download_thumbnail
        
        flash[:notice] = 'Your changes have been saved. Thumbnail changes may take a minute to process.'
        redirect_to edit_admin_publisher_feed_article_path(@article.publisher.slug, @article.feed, @article)
      
      else
        render :edit
      end
    end

    # GET /admin/articles/this_week
    # ----------------------------------------------------
    def this_week
      today = Date.today
      l = today - today.wday
      n = today + (7 - today.wday)
      
      @articles = Article.where('active = true AND publication_date >= ? AND publication_date <= ? ',
                         "#{l.year}-#{l.month}-#{l.day} 00:00:00",
                         "#{n.year}-#{n.month}-#{n.day} 23:59:59").order(publication_date: :desc)
    end

    
    # ====================================================
    private
      def article_params
        params.require(:article).permit(:title, :author, :thumbnail, :publication_date, :content,
                                        :expiration, :active, categories: [])
      end
  end
end