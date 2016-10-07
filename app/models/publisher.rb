class Publisher < ApplicationRecord
  belongs_to :language
  
  has_many :feeds
  has_many :censures
  has_many :redactions
  
  validates :slug, uniqueness: true
end