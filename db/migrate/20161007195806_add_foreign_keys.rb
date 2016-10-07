class AddForeignKeys < ActiveRecord::Migration[5.0]
  def change
    add_reference :censures, :publisher, foreign_key: true
    
    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :post, foreign_key: true
    
    add_reference :feeds, :feed_type, foreign_key: true
    add_reference :feeds, :publisher, foreign_key: true
    
    add_reference :posts, :user, foreign_key: true
    
    add_reference :publishers, :language, foreign_key: true
    
    add_reference :redactions, :publisher, foreign_key: true
    
    add_reference :referrals, :publisher, foreign_key: true
    
    add_reference :users, :language, foreign_key: true
  end
end
