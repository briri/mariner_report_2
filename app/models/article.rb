class Article < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed
  
  has_many :category_articles, dependent: :delete_all
  has_many :categories, through: :category_articles
  
  validates :target, uniqueness: true, presence: true
  
  scope :most_recent, -> { order(publication_date: :desc).limit(25) }

  scope :featured, -> { where(active: true, featured: true).order(publication_date: :desc).includes(:publisher).limit(6) }
  scope :read, -> { where(active: true, latest: 0, featured: false).order(publication_date: :desc).includes(:publisher).limit(6) }
  scope :watch, -> { where(active: true, latest: 1, featured: false).order(publication_date: :desc).includes(:publisher).limit(6) }
  scope :listen, -> { where(active: true, latest: 2, featured: false).order(publication_date: :desc).includes(:publisher).limit(6) }
  scope :racing, -> { where(active: true, latest: 3, featured: false).order(publication_date: :desc).includes(:publisher).limit(6) }
end