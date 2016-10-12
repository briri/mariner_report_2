require 'test_helper'

class CategoryTypeTest < ActiveSupport::TestCase

  # ---------------------------------------------------
  test "required fields are required" do
    assert_not CategoryType.new.valid?
    
    assert CategoryType.new(name: 'test').valid?
  end
  
  # ---------------------------------------------------
  test "name must be unique" do
    name = category_types(:interests).name
    assert_not CategoryType.new(name: name).valid?
    assert CategoryType.new(name: "#{name}_test").valid?
  end
  
  # ---------------------------------------------------
  test "can CRUD" do
    ct = CategoryType.create(name: 'test')
    assert_not ct.id.nil?, "was expecting to be able to create a new CategoryType"

    ct.name = 'test 2'
    ct.save!
    ct.reload
    assert_equal 'test 2', ct.name, "Was expecting to be able to update the name of the CategoryType!"
    
    assert ct.destroy!, "Was unable to delete the CategoryType!"
  end
  
  # ---------------------------------------------------
  test "cannot delete a CategoryTag that has associated Categories" do
    category = Category.new(name: 'test', active: true, tier: 1)
    verify_cannot_delete_belongs_to(category_types(:interests), category)
  end
  
  # ---------------------------------------------------
  test "can manage has_many relationship with Categories" do
    category = Category.new(name: 'test', active: true, tier: 1)
    verify_has_many_relationship(category_types(:interests), category, 
                                 category_types(:interests).categories.count)
  end
end