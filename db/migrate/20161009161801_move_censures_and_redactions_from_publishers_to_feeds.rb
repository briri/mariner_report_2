class MoveCensuresAndRedactionsFromPublishersToFeeds < ActiveRecord::Migration[5.0]
  def change
    remove_reference :censures, :publisher, foreign_key: true
    add_reference :censures, :feed, foreign_key: true
    
    remove_reference :redactions, :publisher, foreign_key: true
    add_reference :redactions, :feed, foreign_key: true
  end
end
