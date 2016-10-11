class Tag < ApplicationRecord
  include Sluggable
  
  has_many :category_tags, dependent: :destroy
  has_many :categories, through: :category_tags
  
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags
  
  validates :name, uniqueness: true
end