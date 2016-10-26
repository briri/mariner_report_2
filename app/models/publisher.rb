class Publisher < ApplicationRecord
  include Sluggable
  
  belongs_to :language
  
  has_many :feeds
  has_many :articles
  
  validates :name, uniqueness: true, presence: true
  
  scope :active, -> { where(active: true).order(:name) }
end