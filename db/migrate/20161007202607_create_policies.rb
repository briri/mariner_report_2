class CreatePolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :policies do |t|
      t.string :name
    end
    
    add_index :policies, :name, unique: true
  end
end
