class CreateTableCensure < ActiveRecord::Migration[5.0]
  def change
    create_table :censures do |t|
      t.string :value
      t.boolean :in_title
      t.boolean :in_content
      
      t.timestamps
    end
    
    add_index :censures, [:value, :in_title]
    add_index :censures, [:value, :in_content]
  end
end
