class Scan < ApplicationRecord
  validates :url, uniqueness: true
end