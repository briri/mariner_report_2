class CreateReferrals < ActiveRecord::Migration[5.0]
  def change
    create_table :referrals do |t|
      t.string :who
      t.string :what
      t.date :when
      t.string :where
      
      t.timestamps
    end
    
    add_index :referrals, [:where, :when, :what]
  end
end
