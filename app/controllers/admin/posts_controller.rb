module Admin
  class PostsController < ApplicationController
    before_action { is_authorized?('add_posts') }
    
    # GET /admin/posts/new
    # ------------------------------------------------
    def new
      @post = Post.new
    end
    
    # GET /admin/posts/[:slug]/edit
    # ------------------------------------------------
    def edit
      @post = Post.find_by(slug: params[:id])
    end
    
    # POST /admin/posts/
    # ----------------------------------------------------
    def create
      attrs = post_params
      
      @post = Post.new(attrs)
    
      @post.user = current_user
    
      if @post.save
        flash[:notice] = 'New post created'
        redirect_to edit_admin_post_path(@post.slug)
      
      else
        @post = Post.new(attrs)
        render :new
      end
    end
    
    # PUT /admin/post/[:slug]/
    # ----------------------------------------------------
    def update
      @post = Post.find_by(slug: params[:id])
      
      if @post.update(post_params)
        flash[:notice] = 'Your changes have been saved'
        redirect_to edit_admin_post_path(@post.slug)
      
      else
        render :edit
      end
    end
    
    # ================================================
    private
      def post_params
        params.require(:post).permit(:name, :content, :active)
      end
  end
end