class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :slug
      t.string :title
      t.text :content
      t.boolean :active
      
      t.timestamps
    end
    
    add_index :posts, [:slug, :title, :active]
  end
end
