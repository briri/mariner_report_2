class Tag < ApplicationRecord
  include Sluggable
  
  has_many :category_tags
  has_many :categories, through: :category_tags
  
  has_many :post_tags
  has_many :posts, through: :post_tags
  
  validates :name, uniqueness: true
end