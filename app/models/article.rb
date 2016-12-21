class Article < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed
  
  has_many :category_articles, dependent: :delete_all
  has_many :categories, through: :category_articles
  
  validates :target, uniqueness: true, presence: true
  
  scope :most_recent, -> { order(publication_date: :desc).limit(25) }
end