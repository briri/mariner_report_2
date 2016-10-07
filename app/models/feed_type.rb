class FeedType < ApplicationRecord
  has_many :feeds
  
  validates :name, uniqueness: true
end