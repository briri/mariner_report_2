class RemoveFacebookAndInstagramFromPublishers < ActiveRecord::Migration[5.0]
  def change
    remove_column :publishers, :facebook
    remove_column :publishers, :instagram
  end
end
