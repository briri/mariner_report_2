class UnknownTag < ApplicationRecord
  belongs_to :publisher

  validates :value, uniqueness: true
end