class CreateTableUnknownTags < ActiveRecord::Migration[5.0]
  def change
    create_table :unknown_tags do |t|
      t.string :value
    end
    
    add_index :unknown_tags, :value
    
    add_reference :unknown_tags, :article, foreign_key: true
  end
end
