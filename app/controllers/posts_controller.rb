class PostsController < ApplicationController
  
  def show
    @post = Post.find_by_path(params[:year], params[:month], 
                              params[:day], params[:id])
    render 'blog/posts/show'
  end
  
end