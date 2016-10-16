class Contact < ApplicationRecord
  
  validates :email, email: true, presence: true
  validates :message, presence: true
end