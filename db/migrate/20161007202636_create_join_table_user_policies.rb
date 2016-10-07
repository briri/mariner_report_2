class CreateJoinTableUserPolicies < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :policies do |t|
      t.index [:user_id, :policy_id]
      t.index [:policy_id, :user_id]
    end
  end
end
