class CreateFeedFailures < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_failures do |t|
      t.text :message
      
      t.timestamps
    end
    
    add_reference :feed_failures, :feed, foreign_key: true
  end
end
