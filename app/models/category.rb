class Category < ApplicationRecord
  has_many :tags, through: :category_tags
  
  validates :name, uniqueness: true
end