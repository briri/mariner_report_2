class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments
  has_many :tags, through: :post_tags
  
  validates :slug, uniqueness: true
end