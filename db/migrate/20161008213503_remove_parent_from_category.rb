class RemoveParentFromCategory < ActiveRecord::Migration[5.0]
  def change
    remove_reference :categories, :category, foreign_key: true
  end
end
