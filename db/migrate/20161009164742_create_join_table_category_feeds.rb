class CreateJoinTableCategoryFeeds < ActiveRecord::Migration[5.0]
  def change
    create_join_table :categories, :feeds do |t|
      t.index [:category_id, :feed_id]
      t.index [:feed_id, :category_id]
    end
  end
end
