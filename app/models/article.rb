class Article < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed
  
  has_many :category_articles, dependent: :delete_all
  has_many :categories, through: :category_articles
  
  validates :target, uniqueness: true, presence: true
  
  scope :most_recent, -> { order(publication_date: :desc).limit(25) }

  scope :featured, -> { joins(:feed).where('articles.active = true AND feeds.featured = ?', true).order(publication_date: :desc).includes(:publisher)}
  scope :read, -> { joins(:feed, :categories).where("articles.active = true AND feeds.featured = ? AND categories.slug IN (?)", false, ['couples', 'families', 'gear', 'conservation', 'magazines', 'maintenance', 'safety', 'solo', 'travel']).order(publication_date: :desc).includes(:publisher) }
  scope :watch, -> { joins(:feed, :categories).where("articles.active = true AND feeds.featured = ? AND categories.slug IN (?)", false, ['video']).order(publication_date: :desc).includes(:publisher) }
  scope :listen, -> { joins(:feed, :categories).where("articles.active = true AND feeds.featured = ? AND categories.slug IN (?)", false, ['podcast']).order(publication_date: :desc).includes(:publisher) }
  scope :racing, -> { joins(:feed, :categories).where("articles.active = true AND feeds.featured = ? AND categories.slug IN (?)", false, ['race', 'vendee', 'volvo-ocean-race', 'women-in-racing', 'olympics', 'clipper', 'americas-cup'] ).order(publication_date: :desc).includes(:publisher) }
end