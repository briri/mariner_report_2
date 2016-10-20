class Category < ApplicationRecord
  include Sluggable
  
  belongs_to :category_type

  # -----------------------------------
  has_many :category_tags, dependent: :delete_all
  has_many :tags, through: :category_tags
  
  has_many :category_feeds, dependent: :delete_all
  has_many :feeds, through: :category_feeds
  
  has_many :category_articles, dependent: :delete_all
  has_many :articles, through: :category_articles
  
  # -----------------------------------
  validates :name, uniqueness: true
  validates :name, :slug, :tier, :active, presence: true
  
  scope :active, -> { where(active: true).order(:name) }
end