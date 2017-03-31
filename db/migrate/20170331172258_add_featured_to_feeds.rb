class AddFeaturedToFeeds < ActiveRecord::Migration[5.0]
  def change

    add_column :feeds, :featured, :boolean, default: false

  end
end
