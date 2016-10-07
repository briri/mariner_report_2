class RenameFieldsOnReferrals < ActiveRecord::Migration[5.0]
  def change
    rename_column :referrals, :who, :origin
    rename_column :referrals, :what, :target

    remove_column :referrals, :when
    remove_column :referrals, :where
    
    add_column :referrals, :reported, :boolean
  end
end
