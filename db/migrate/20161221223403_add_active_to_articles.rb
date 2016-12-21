class AddActiveToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :active, :boolean, default: true
  end
end
