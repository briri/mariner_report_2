class AddActiveToUnknownTags < ActiveRecord::Migration[5.0]
  def change
    add_column :unknown_tags, :active, :boolean, default: true
  end
end
