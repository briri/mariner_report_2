class AddCategoryReferenceToPublishers < ActiveRecord::Migration[5.0]
  def change
    add_reference :publishers, :category, foreign_key: true
  end
end
