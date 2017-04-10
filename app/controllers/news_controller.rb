class NewsController < ApplicationController
  
  # GET /
  # -------------------------------------------------------------------
  def index
    @featured = Article.featured.first
    
    watch = Article.watch.uniq
    listen = Article.listen.uniq
    read = Article.read.uniq
    racing = Article.racing.uniq

    @read = read.select{|a| (!watch.include?(a) && !listen.include?(a)) }[0..5]
    @racing = racing.select{|a| (!watch.include?(a) && !listen.include?(a)) }[0..5]
    @watch = watch[0..5]
    @listen = listen[0..5]
  end
  
end