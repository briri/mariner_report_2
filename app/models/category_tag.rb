class CategoryTag < ApplicationRecord
  self.table_name = "categories_tags"
  
  belongs_to :category
  belongs_to :tag
end