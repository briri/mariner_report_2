class MoveCssSelectorFromPublisherToFeed < ActiveRecord::Migration[5.0]
  def change
    remove_column :publishers, :article_css_selector
    add_column :feeds, :article_css_selector, :string
  end
end
