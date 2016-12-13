class Publisher < ApplicationRecord
  include Sluggable
  
  belongs_to :language
  
  has_many :feeds, dependent: :delete_all
  has_many :articles, dependent: :delete_all
  has_many :unknown_tags, dependent: :delete_all
  
  validates :name, uniqueness: true, presence: true
  
  scope :active, -> { where(active: true).order(:name) }
end