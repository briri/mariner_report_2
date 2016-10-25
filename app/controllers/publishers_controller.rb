class PublishersController < ApplicationController
  
  before_action :authenticate_user!, only: [:edit, :new, :update, :create, :destroy]
  
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
    is_authorized?('edit_publishers')
    
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
    
  end
  
  # POST /publishers/
  # ----------------------------------------------------
  def create
    
  end
  
  # DELETE /publishers/[:slug]
  # ----------------------------------------------------
  def destroy
    
  end
  
end