class AddFailedToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :failed, :boolean, default: false
    
    add_column :feed_failures, :severity, :integer, default: 0
  end
end
