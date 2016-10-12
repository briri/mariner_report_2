require 'test_helper'

class TagTest < ActiveSupport::TestCase
  
  setup do
    @category = Category.create(name: 'test', active: true, tier: 1, 
                                category_type: category_types(:interests))
  end
                              
  # ---------- required fields are required ------------
  test "required fields should be required" do
    assert_not Tag.new.valid?
    
    assert Tag.new(name: 'test tag').valid?
  end
  
  # ---------- uniqueness ----------
  test "name should be unique" do
    assert_not Tag.new(name: tags(:alpha).name).valid?
    assert Tag.new(name: "#{tags(:alpha).name} test").valid?
  end
  
  # ---------- name ----------
  test "name should create slug" do
    tag = Tag.new(name: 'testTag')
    assert_equal(tag.name.downcase(), tag.slug)
  end

  # ---------------------------------------------------
  test "can CRUD" do
    tag = Tag.create(name: 'test tag')
    assert_not tag.id.nil?, "was expecting to be able to create a new Tag: #{tag.errors.map{|f, m| f.to_s + ' ' + m}.join(', ')}"

    tag.name = 'test2'
    tag.save!
    tag.reload
    assert_equal 'test2', tag.name, "Was expecting to be able to update the name of the Tag!"
    
    assert tag.destroy, "Was unable to delete the Tag!"
  end
  
  # ---------------------------------------------------
  test "deleting the Tag should remove its relationships with Categories" do
    tag = Tag.create(name: 'test tag')
    verify_has_many_through_deletion(tag, @category)
  end
  
  # ---------------------------------------------------
  test "deleting the Tag should remove its relationships with Posts" do
    #tag = Tag.create(name: 'test tag')
    #verify_has_many_through_deletion(tag, @category)
  end
  
  # ---------------------------------------------------
  test "can manage has_many relationship with Categories" do
    tag = Tag.create(name: 'test tag')
    verify_has_many_relationship(tag, @category, tag.categories.count)
  end

  # ---------------------------------------------------
  test "can manage has_many relationship with Posts" do
    #tmplt = Dmptemplate.new(title: 'Added through test')
    #verify_has_many_relationship(@org, tmplt, @org.dmptemplates.count)
  end
  
end
