module Admin
  class FeedsController < ApplicationController
  
    before_action only: [:new, :create] { is_authorized?('add_publishers') }
    before_action only: [:edit, :update] { is_authorized?('edit_publishers') }
  
    # GET /feeds
    # ----------------------------------------------------
    def index
      @feeds = Feeds.order(:source)
    end
  
    # GET /feeds/[:id]/edit
    # ----------------------------------------------------
    def edit
      @publisher = Publisher.find_by(slug: params[:publisher_id])
      @feed = Feed.find(params[:id])
      get_dependencies
    end
  
    # GET /feeds/new
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
  
    # PUT /feeds/[:id]
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
  
    # POST /feeds/
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
    
  puts "VALID? #{feed.valid?}"
    
      if feed.save
  puts "YEP"
        flash[:notice] = 'New feed created'
        redirect_to edit_admin_publisher_path(@publisher.slug)
      
      else
  puts "NOPE #{feed.inspect}"
        @feed = Feed.new(attrs)
        get_dependencies
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
                                     :next_scan_on, :max_article_age_in_days, :source,
                                     :scan_frequency_in_hours, :active,
                                     categories: [])
      end
    
      # ----------------------------------------------------
      def get_dependencies
        @types = FeedType.order(:name)
        @categories = Category.order(:name)
        @articles = @publisher.articles.order(publication_date: :desc).limit(6)
      end
  end
end