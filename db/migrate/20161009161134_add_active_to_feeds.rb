class AddActiveToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :active, :boolean
  end
end
