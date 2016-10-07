class CreateTableRedaction < ActiveRecord::Migration[5.0]
  def change
    create_table :redactions do |t|
      t.string :value
      t.boolean :in_title
      t.boolean :in_content
      
      t.timestamps
    end
    
    add_index :redactions, [:value, :in_title]
    add_index :redactions, [:value, :in_content]
  end
end
