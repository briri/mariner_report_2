class CategoriesController < ApplicationController
  
  # GET /categories/[:slug]
  # ----------------------------------------------------
  def show
    @category = Category.eager_load(:articles).
        find_by('category.slug = ? AND articles.active = true', params[:id])
  end
  
end