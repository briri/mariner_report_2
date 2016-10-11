class Post < ApplicationRecord
  include Sluggable
  
  belongs_to :user
  
  has_many :comments
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  
  before_save check_slug
  
  private
    # We want the slug to be unique but cannot expect the post's name to be 
    # unique, so if the slug already exists, prepend the date to the slug
    def check_slug
      now = today
      post = Post.where(slug: self.slug)
      self.slug = "#{now.year}-#{now.month}-#{now.day}-#{slug}".slice(0, 254) 
    end
end