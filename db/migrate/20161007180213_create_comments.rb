class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :content
      t.boolean :moderated
      t.boolean :active
      
      t.timestamps
    end
    
    add_index :comments, [:moderated, :active]
  end
end
