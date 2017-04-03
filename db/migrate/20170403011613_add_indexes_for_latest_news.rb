class AddIndexesForLatestNews < ActiveRecord::Migration[5.0]
  def change
    add_index :categories, [:id, :slug]
  end
end
