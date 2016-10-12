require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category_type = CategoryType.first
    
    @params = {name: 'test', 
               active: true, 
               category_type: @category_type,
               tier: 1}
  end
  
  # ---------- required fields are required ------------
  test "required fields should be required" do
    assert_not Category.new.valid?
    assert_not Category.new(name: 'test').valid?
    assert_not Category.new(active: true).valid?
    assert_not Category.new(tier: 1).valid?
    assert_not Category.new(name: 'test', active: true).valid?
    assert_not Category.new(name: 'test', tier: 1).valid?
    assert_not Category.new(tier: 1, active: true).valid?
    
    assert Category.new(@params).valid?
  end
  
  # ---------- name ----------
  test "name should create slug" do
    category = Category.new(name: 'testing')
    assert_equal(category.name.downcase(), category.slug)
  end

  # ---------------------------------------------------
  test "tier should be an integer" do
    
  end

  # ---------------------------------------------------
  test "active should be a boolean" do

  end

  # ---------------------------------------------------
  test "can CRUD" do
    category = Category.create(@params)
    assert_not category.id.nil?, "was expecting to be able to create a new Category: #{category.errors.map{|f, m| f.to_s + ' ' + m}.join(', ')}"

    category.tier = 2
    category.save!
    category.reload
    assert_equal 2, category.tier, "Was expecting to be able to update the tier of the Category!"
    
    assert category.destroy!, "Was unable to delete the Category!"
  end
  
  # ---------------------------------------------------
  test "deleting the Category should remove its relationships with Articles" do
    #tag = Tag.create(name: 'test tag')
    #verify_has_many_through_deletion(tag, @category)
  end
  
  # ---------------------------------------------------
  test "deleting the Category should remove its relationships with Feeds" do
    #tag = Tag.create(name: 'test tag')
    #verify_has_many_through_deletion(tag, @category)
  end
  
  # ---------------------------------------------------
  test "deleting the Category should remove its relationships with Tags" do
    tag = Tag.create(name: 'testTag')
    category = Category.create(@params)
    
    verify_has_many_through_deletion(category, tag)
  end
  
  # ---------------------------------------------------
  test "can manage has_many relationship with Articles" do
    #usr = User.create(email: 'test@testing.org', password: 'testing1234')
    #verify_has_many_relationship(@org, usr, @org.users.count)
  end

  # ---------------------------------------------------
  test "can manage has_many relationship with Feeds" do
    #tmplt = Dmptemplate.new(title: 'Added through test')
    #verify_has_many_relationship(@org, tmplt, @org.dmptemplates.count)
  end
  
  # ---------------------------------------------------
  test "can manage has_many relationship with Tags" do
    tag = Tag.new(name: 'testTag')
    category = Category.create(@params)
    
    verify_has_many_relationship(category, tag, category.tags.count)
  end
  
  # ---------------------------------------------------
  test "can manage belongs_to relationship with CategoryType" do
    category = Category.create(@params)
    verify_belongs_to_relationship(category, @category_type)
  end
  
end
