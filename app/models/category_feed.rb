class CategoryFeed < ApplicationRecord
  self.table_name = "categories_feeds"
  
  belongs_to :category
  belongs_to :feed
end