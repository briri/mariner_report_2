class CategoryArticle < ApplicationRecord
  self.table_name = "categories_articles"
  
  belongs_to :category
  belongs_to :article
end