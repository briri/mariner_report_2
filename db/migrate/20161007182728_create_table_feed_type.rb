class CreateTableFeedType < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_types do |t|
      t.string :name
      
      t.timestamps
    end
    
    add_index :feed_types, :name
  end
end
