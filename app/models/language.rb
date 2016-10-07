class Language < ApplicationRecord
  has_many :publishers
  
  validates :abbreviation, uniqueness: true
end