class Policy < ApplicationRecord
  has_many :users, through: :user_policies
  
  validates :name, uniqueness: true
end