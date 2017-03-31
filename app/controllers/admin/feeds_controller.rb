module Admin
  class FeedsController < ApplicationController
  
    before_action only: [:new, :create] { is_authorized?('add_publishers') }
    before_action only: [:edit, :update, :rescan_all_articles] { is_authorized?('edit_publishers') }
  
    # GET /admin/publishers/[:publisher_id]/feeds
    # ----------------------------------------------------
    def index
      @feeds = Feeds.order(:source)
    end
  
    # GET /admin/publishers/[:publisher_id]/feeds/[:id]/edit
    # ----------------------------------------------------
    def edit
      @publisher = Publisher.find_by(slug: params[:publisher_id])
      @feed = Feed.find(params[:id])
      get_dependencies
    end
  
    # GET /admin/publishers/[:publisher_id]/feeds/new
    # ----------------------------------------------------
    def new
      @publisher = Publisher.find_by(slug: params[:publisher_id])
      @feed = Feed.new(publisher: @publisher,
                       feed_type: FeedType.find_by(name: 'rss'),
                       max_article_age_in_days: 60,
                       scan_frequency_in_hours: 4,
                       next_scan_on: Time.now,
                       active: true)
      get_dependencies
    end
  
    # PUT /admin/publishers/[:publisher_id]/feeds/[:id]
    # ----------------------------------------------------
    def update
      @publisher = Publisher.find_by(id: params[:publisher_id])
      @feed = Feed.find(params[:id])
      get_dependencies
    
      attrs = feed_params
    
      attrs[:feed_type] = FeedType.find(attrs[:feed_type])
    
      cats = []
      attrs[:categories].each do |cat|
        cats << Category.find(cat) unless cat.empty?
      end
      attrs[:categories] = cats
    
      attrs[:active] = (attrs[:active] == '0' ? false : true)

      if @feed.update(attrs)
        flash[:notice] = 'Your changes have been saved'
        redirect_to edit_admin_publisher_feed_path(@publisher.slug, @feed)
      
      else
        render :edit
      end
    end
  
    # POST /admin/publishers/[:publisher_id]/feeds/
    # ----------------------------------------------------
    def create
      @publisher = Publisher.find(params[:publisher_id])
    
      attrs = feed_params
    
      attrs[:publisher] = @publisher
      attrs[:feed_type] = FeedType.find(attrs[:feed_type])
    
      cats = []
      attrs[:categories].each do |cat|
        cats << Category.find(cat) unless cat.empty?
      end
      attrs[:categories] = cats
    
      feed = Feed.new(attrs)
    
      if feed.save
        flash[:notice] = 'New feed created'
        redirect_to edit_admin_publisher_path(@publisher.slug)
      
      else
        @feed = Feed.new(attrs)
        get_dependencies
        render :new
      end
    end
  
    # DELETE /admin/publishers/[:publisher_id]/feeds/[:id]
    # ----------------------------------------------------
    def destroy

    end
  
    # POST /admin/publishers/[:publisher_id]/feeds/[:id]/scan
    # ----------------------------------------------------
    def scan
      @feed = Feed.find(params[:feed_id])
      
      # Scan the feed
      ScanFeedJob.perform_now(feed)
    
      flash[:notice] = 'Scanning this feed. This may take a few minutes.'
      redirect_to edit_admin_publisher_feed_path(@feed.publisher.slug, @feed)
    end
  
    # POST /admin/publishers/[:publisher_id]/feeds/[:id]/rescan_all_articles
    # ----------------------------------------------------
    def rescan_all_articles
      @feed = Feed.find(params[:feed_id])
      
      scrub_all_articles
      
      # Scan the feed
      ScanFeedJob.perform_now(feed)
      
      flash[:notice] = 'Removing old articles and rescanning feed. This may take a few minutes.'
      redirect_to edit_admin_publisher_feed_path(@feed.publisher.slug, @feed)
    end
    
  
    # ====================================================
    private
      def feed_params
        params.require(:feed).permit(:feed_type, :publisher, :article_css_selector, 
                                     :next_scan_on, :max_article_age_in_days, :source,
                                     :scan_frequency_in_hours, :active,
                                     categories: [])
      end
    
      # ----------------------------------------------------
      def get_dependencies
        @types = FeedType.order(:name)
        @categories = Category.order(:name)
        @articles = @feed.articles.order(publication_date: :desc).limit(6)
      end
      
      # ----------------------------------------------------
      def scrub_all_articles
        # Delete the articles and remove their thumbnails
        @feed.articles.each do |article|
          ScrubberService.scrub(article)
        end
      end
   
  end
end