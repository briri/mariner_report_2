class CreateFeed < ActiveRecord::Migration[5.0]
  def change
    create_table :feeds do |t|
      t.string :source
      
      t.timestamps
    end
    
    add_index :feeds, :source
  end
end
