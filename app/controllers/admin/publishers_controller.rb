module Admin 
  class PublishersController < ApplicationController
    
    before_action only: [:new, :create] { is_authorized?('add_publishers') }
    before_action only: [:edit, :update, :index, :show] { is_authorized?('edit_publishers') }
    
    # GET /admin/publishers
    # ----------------------------------------------------
    def index
      @sort = params[:sort] ||= 'slug'
      @dir = params[:dir] ||= 'asc'
      
      @publishers = Publisher.all.order("#{@sort.to_sym}": @dir.to_sym)
    end
  
    # GET /admin/publishers/[:slug]/edit
    # ----------------------------------------------------
    def edit
      @publisher = Publisher.find_by(slug: params[:id])
      @languages = Language.order(:name)
    end
  
    # GET /admin/publishers/new
    # ----------------------------------------------------
    def new
      @publisher = Publisher.new
      @languages = Language.order(:name)
    end
  
    # PUT /admin/publishers/[:slug]
    # ----------------------------------------------------
    def update
      @publisher = Publisher.find_by(slug: params[:id])
      @languages = Language.order(:name)
    
      attrs = publisher_params
      attrs[:language] = Language.find(attrs[:language])
    
      if @publisher.update(attrs)
        flash[:notice] = 'Your changes have been saved'
        render :edit
      
      else
        render :edit
      end
    end
  
    # POST /admin/publishers/
    # ----------------------------------------------------
    def create
      @contact = Contact.new(contact_params)
      @languages = Language.order(:name)
    
      if @contact.save
        render 'confirmation'
      else
        render :new
      end
    end
  
    # DELETE /admin/publishers/[:slug]
    # ----------------------------------------------------
    def destroy
      publisher = Publisher.find_by(slug: params[:id])
      publisher.update(active: false)
    end
  
    # ====================================================
    private
      def publisher_params
        params.require(:publisher).permit(:name, :description, :homepage, :language, :active)
      end
  end
end