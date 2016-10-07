class CreateCategoryTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :category_types do |t|
      t.string :name
    end
    
    add_index :category_types, :name
    
    add_reference :categories, :category_type, foreign_key: true
  end
end
