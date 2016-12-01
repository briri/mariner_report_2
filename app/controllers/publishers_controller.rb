class PublishersController < ApplicationController
  
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
  
end