class AddParentToCategory < ActiveRecord::Migration[5.0]
  def change
    add_reference :categories, :category, foreign_key: true, as: :parent
  end
end
