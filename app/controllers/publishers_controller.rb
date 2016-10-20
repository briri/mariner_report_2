class PublishersController < ApplicationController
  
  # GET /publishers/[:slug]
  # ----------------------------------------------------
  def show
    @publisher = Publisher.find_by(slug: params[:id])
  end
  
end