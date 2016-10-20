class AddThumbnailToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :thumbnail, :string
    rename_column :publishers, :logo, :thumbnail
  end
end
