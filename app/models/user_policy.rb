class UserPolicy < ApplicationRecord
  self.table_name = "policies_users"
  
  belongs_to :user
  belongs_to :policy
end