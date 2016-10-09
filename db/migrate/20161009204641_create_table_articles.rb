class CreateTableArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :target
      t.string :title
      t.string :author
      t.string :media
      t.string :thumbnail
      t.string :media_type
      t.string :media_host
      t.date :publication_date
      t.text :content
      t.date :expiration
    end
    
    add_index :articles, :target
    add_index :articles, :expiration
    
    add_reference :articles, :publisher, foreign_key: true
  end
end
