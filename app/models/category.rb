class Category < ApplicationRecord
  include Sluggable
  
  belongs_to :category_type

  has_many :category_tags
  has_many :tags, through: :category_tags
  
  has_many :category_feeds
  has_many :feeds, through: :category_feeds
  
  validates :name, uniqueness: true
end