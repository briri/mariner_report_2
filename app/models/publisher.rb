class Publisher < ApplicationRecord
  include Sluggable
  
  belongs_to :language
  
  has_many :feeds
  
  validates :name, uniqueness: true
end