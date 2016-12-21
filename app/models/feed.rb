class Feed < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed_type
  
  has_many :articles

  has_many :category_feeds, dependent: :delete_all
  has_many :categories, through: :category_feeds
  
  has_many :censures
  has_many :redactions
  
  validates :source, :publisher, :feed_type, :next_scan_on, 
            :max_article_age_in_days, :scan_frequency_in_hours, presence: true
                       
  validates :source, uniqueness: true
  validates :source, url: true
end