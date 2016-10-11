class Article < ApplicationRecord
  belongs_to :publisher
  
  has_many :unknown_tags
  
  has_many :category_articles
  has_many :categories, through: :category_articles
end