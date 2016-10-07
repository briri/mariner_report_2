class Feed < ApplicationRecord
  belongs_to :publisher
  belongs_to :feed_type
  
  validates :source, uniqueness: true
end