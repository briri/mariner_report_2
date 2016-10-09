class Article < ApplicationRecord
  belongs_to :publisher
  
  has_many :unknown_tags
end