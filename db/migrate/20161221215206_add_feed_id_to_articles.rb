class AddFeedIdToArticles < ActiveRecord::Migration[5.0]
  def change
    add_reference :articles, :feed, foreign_key: true
  end
end
