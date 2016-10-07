class CreateJoinTableCategoryTag < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :tags do |t|
      t.index [:category_id, :tag_id]
      t.index [:tag_id, :category_id]
    end
  end
end
