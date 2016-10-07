class Tag < ApplicationRecord
  has_many :categories, through: :category_tags
  has_many :posts, through: :post_tags
  
  validates :name, uniqueness: true
end