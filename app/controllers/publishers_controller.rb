class PublishersController < ApplicationController
  
  before_action only: [:new, :create] { is_authorized?('add_publishers') }
  before_action only: [:edit, :update] { is_authorized?('edit_publishers') }
  
  # GET /publishers
  # ----------------------------------------------------
  def index
    @publishers = Publisher.order(:name)
  end
  
  # GET /publishers/[:slug]
  # ----------------------------------------------------
  def show
    @publisher = Publisher.find_by(slug: params[:id])
  end
  
  # GET /publishers/[:slug]/edit
  # ----------------------------------------------------
  def edit
    @publisher = Publisher.find_by(slug: params[:id])
    @categories = Category.order(:name)
    @languages = Language.order(:name)
  end
  
  # GET /publishers/new
  # ----------------------------------------------------
  def new
    
  end
  
  # PUT /publishers/[:slug]
  # ----------------------------------------------------
  def update
    @publisher = Publisher.find_by(slug: params[:id])
    @categories = Category.order(:name)
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
  
  # POST /publishers/
  # ----------------------------------------------------
  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      render 'confirmation'
    else
      render :new
    end
  end
  
  # DELETE /publishers/[:slug]
  # ----------------------------------------------------
  def destroy
    
  end
  
  # ====================================================
  private
    def publisher_params
      params.require(:publisher).permit(:name, :description, :homepage, :language, :active)
    end
end