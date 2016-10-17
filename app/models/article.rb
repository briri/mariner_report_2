class Article < ApplicationRecord
  belongs_to :publisher
  
  has_many :unknown_tags
  
  has_many :category_articles, dependent: :delete_all
  has_many :categories, through: :category_articles
  
  scope :most_recent, -> { order(publication_date: :desc).limit(25) }
end