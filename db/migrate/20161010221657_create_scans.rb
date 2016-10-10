class CreateScans < ActiveRecord::Migration[5.0]
  def change
    create_table :scans do |t|
      t.string :url
    end
    
    add_index :scans, :url 
  end
end
