class CreateTableLanguage < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :abbreviation
      
      t.timestamps
    end
    
    add_index :languages, :abbreviation
  end
end
