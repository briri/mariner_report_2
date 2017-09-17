module Admin 
  class CategoriesController < ApplicationController
    
    before_action only: [:new, :create] { is_authorized?('add_publishers') }
    before_action only: [:edit, :update, :index, :show] { is_authorized?('edit_publishers') }
    
    # GET /admin/categories
    # ----------------------------------------------------
    def index
      @sort = params[:sort] ||= 'slug'
      @dir = params[:dir] ||= 'asc'
      
      @categories = Category.eager_load(:articles, :feeds, :tags).all.order("#{@sort.to_sym}": @dir.to_sym)
    end
  
    # GET /admin/categories/[:slug]/edit
    # ----------------------------------------------------
    def edit
      @category = Category.eager_load(:articles, :feeds, :tags).find_by(slug: params[:id])
    end
  
    # GET /admin/categories/new
    # ----------------------------------------------------
    def new
      @category = Category.new
    end
  
    # PUT /admin/categories/[:slug]
    # ----------------------------------------------------
    def update
      @category = Category.find_by(slug: params[:id])
    
      attrs = category_params
    
      if @category.update(attrs)
        flash[:notice] = 'Your changes have been saved'
        redirect_to edit_admin_category_path(@category.slug)
      
      else
        render :edit
      end
    end
  
    # POST /admin/categories/
    # ----------------------------------------------------
    def create
      attrs = category_params
    
      @category = Category.new(attrs)
      if @category.save
        redirect_to edit_admin_category_path(@category.slug)
      else
        render :new
      end
    end
  
    # DELETE /admin/categories/[:slug]
    # ----------------------------------------------------
    def destroy
      category = Category.find_by(slug: params[:id])
      category.update(active: false)
    end
  
    # ====================================================
    private
      def category_params
        params.require(:category).permit(:name, :active, :slug, :thumbnail, :category_type_id)
      end
  end
end