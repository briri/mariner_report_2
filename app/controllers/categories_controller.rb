class CategoriesController < ApplicationController
  
  # GET /categories/[:slug]
  # ----------------------------------------------------
  def show
    @category = Category.find_by(slug: params[:id])
  end
  
end