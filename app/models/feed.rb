class Feed < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed_type

  has_many :category_feeds, dependent: :destroy
  has_many :categories, through: :category_feeds
  
  has_many :censures
  has_many :redactions
  
  validates :source, uniqueness: true
end