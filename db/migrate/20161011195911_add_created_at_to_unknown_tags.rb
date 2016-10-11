class AddCreatedAtToUnknownTags < ActiveRecord::Migration[5.0]
  def change
    add_column :unknown_tags, :created_at, :datetime
  end
end
