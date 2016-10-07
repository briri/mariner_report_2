class CreatePublishers < ActiveRecord::Migration[5.0]
  def change
    create_table :publishers do |t|
      t.string :slug
      t.string :name
      t.string :description
      t.string :homepage
      t.string :facebook
      t.string :instagram
      t.string :logo
      t.boolean :active

      t.string :article_css_selector
      
      t.date :last_scan_on
      t.date :next_scan_on
      t.date :last_article_from
      
      t.integer :max_article_age
      t.integer :scan_frequency_in_hours
      
      t.timestamps
    end
    
    add_index :publishers, [:slug, :active]
    add_index :publishers, [:slug, :active, :last_article_from]

    # Used by the investigator to scan for new content
    add_index :publishers, [:slug, :next_scan_on]
    add_index :publishers, [:slug, :max_article_age]
  end
end
