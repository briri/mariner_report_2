class FeedsController < ApplicationController
  
  before_action only: [:new, :create] { is_authorized?('add_publishers') }
  before_action only: [:edit, :update] { is_authorized?('edit_publishers') }
  
  # GET /feeds
  # ----------------------------------------------------
  def index
    @feeds = Feeds.order(:source)
  end
  
  # GET /feeds/[:id]
  # ----------------------------------------------------
  def show
    @feed = Feed.find(params[:id])
    get_dependencies
  end
  
  # GET /feeds/[:id]/edit
  # ----------------------------------------------------
  def edit
    @feed = Feed.find(params[:id])
    get_dependencies
  end
  
  # GET /feeds/new
  # ----------------------------------------------------
  def new
    @feed = Feed.new
    get_dependencies
  end
  
  # PUT /feeds/[:id]
  # ----------------------------------------------------
  def update
    @feed = Feed.find(params[:id])
    get_dependencies
    
    attrs = feed_params
    attrs[:feed_type] = FeedType.find(attrs[:feed_type])
    
    if @feed.update(attrs)
      flash[:notice] = 'Your changes have been saved'
      render :edit
      
    else
      render :edit
    end
  end
  
  # POST /feeds/
  # ----------------------------------------------------
  def create
    @feed = Feed.new(feed_params)
    get_dependencies
    
    if @feed.save
      flash[:notice] = 'Your changes have been saved'
      redirect_to edit_publisher_path(@feed.publisher)
      
    else
      render :new
    end
  end
  
  # DELETE /feeds/[:id]
  # ----------------------------------------------------
  def destroy
    
  end
  
  # ====================================================
  private
    def feed_params
      params.require(:feed).permit(:feed_type, :publisher, :article_css_selector, 
                                   :next_scan_on, :max_article_age_in_days, 
                                   :scan_frequency_in_hours, :categories, :active)
    end
    
    # ----------------------------------------------------
    def get_dependencies
      @types = FeedType.order(:name)
      @categories = Category.order(:name)
      @articles = @feed.publisher.articles.order(publication_date: :desc).limit(6)
    end
end