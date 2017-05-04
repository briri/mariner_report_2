class AddLatestAndFeaturedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :featured, :boolean, default: false
    add_column :articles, :latest, :integer
    
    add_index :articles, :latest
  end
end
