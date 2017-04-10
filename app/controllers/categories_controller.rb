class CategoriesController < ApplicationController
  
  # GET /categories/[:slug]
  # ----------------------------------------------------
  def show
    @category = Category.eager_load(:articles).
        find_by('articles.slug = ? AND active = true', params[:id])[0..59]
  end
  
end