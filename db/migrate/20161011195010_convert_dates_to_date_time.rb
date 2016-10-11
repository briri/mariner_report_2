class ConvertDatesToDateTime < ActiveRecord::Migration[5.0]
  def change
    change_column :feeds, :last_scan_on, :datetime
    change_column :feeds, :next_scan_on, :datetime
    change_column :feeds, :last_article_from, :datetime
    
    change_column :articles, :publication_date, :datetime
    change_column :articles, :expiration, :datetime
    add_column :articles, :created_at, :datetime
    add_column :articles, :updated_at, :datetime
    
    add_column :scans, :created_at, :datetime
  end
end
