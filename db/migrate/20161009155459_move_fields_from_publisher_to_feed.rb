class MoveFieldsFromPublisherToFeed < ActiveRecord::Migration[5.0]
  def change
    remove_column :publishers, :last_scan_on
    add_column :feeds, :last_scan_on, :date
    
    remove_column :publishers, :next_scan_on
    add_column :feeds, :next_scan_on, :date
    
    remove_column :publishers, :last_article_from
    add_column :feeds, :last_article_from, :date
    
    remove_column :publishers, :max_article_age
    add_column :feeds, :max_article_age_in_days, :integer
    
    remove_column :publishers, :scan_frequency_in_hours
    add_column :feeds, :scan_frequency_in_hours, :integer
    
    remove_reference :publishers, :category, foreign_key: true
    add_reference :feeds, :category, foreign_key: true
  end
end
