class RenameArticlesCategoriesToCategoriesArticles < ActiveRecord::Migration[5.0]
  def change
    rename_table :articles_categories, :categories_articles
  end
end
