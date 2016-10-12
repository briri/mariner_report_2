ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  # Convert Ruby Class Names into attribute names (e.g. MyClass --> my_class)
  # ----------------------------------------------------------------------
  def class_name_to_attribute_name(name)
    name.gsub(/([a-z]+)([A-Z])/, '\1_\2').gsub('-', '_').downcase
  end
  
  
# UNIT TEST HELPERS
  # ----------------------------------------------------------------------
  def verify_has_many_relationship(object, new_association, initial_expected_count)
    # Assumes that the association name matches the pluralized name of the class
    rel = "#{class_name_to_attribute_name(new_association.class.name).pluralize}"
    
    assert_equal initial_expected_count, object.send(rel).count, "was expecting #{object.class.name} to initially have #{initial_expected_count} #{rel}"
    
    # Add another association for the object
    object.send(rel) << new_association
    object.save!
    assert_equal (initial_expected_count + 1), object.send(rel).count, "was expecting #{object.class.name} to have #{initial_expected_count + 1} #{rel} after adding a new one"
    
    # Remove the newly added association
    object.send(rel).delete(new_association)
    object.save!
    assert_equal initial_expected_count, object.send(rel).count, "was expecting #{object.class.name} to have #{initial_expected_count} #{rel} after removing the new one we added"
  end
  
  # ----------------------------------------------------------------------
  def verify_belongs_to_relationship(child, parent)
    # Assumes that the association name matches the lower case name of the class
    prnt = "#{class_name_to_attribute_name(parent.class.name)}"
    chld = "#{class_name_to_attribute_name(child.class.name)}"
    
    child.send("#{prnt}=", parent)
    child.save!
    assert_equal parent, child.send(prnt), "was expecting #{chld} to have a #{prnt}.id == #{parent.id}"
    
    # Search the parent for the child
    parent.reload
    assert_includes parent.send("#{chld.pluralize}"), child, "was expecting the #{prnt}.#{chld.pluralize} to contain the #{chld}"
  end

  # ----------------------------------------------------------------------
  def verify_has_many_through_deletion(object, association)
    # Assumes that the association name matches the pluralized name of the class
    obj = "#{class_name_to_attribute_name(object.class.name).pluralize}"
    rel = "#{class_name_to_attribute_name(association.class.name).pluralize}"
    id = association.id
    
    object.send(rel) << association
    object.save!

    assert object.send(rel).include?(association), "was expecting to have been able to add a #{association.class.name} to the #{object.class.name}!"
    
    assert object.destroy!, "was expecting to be able to delete the #{object.class.name}"
    
    relation = Object.const_get(association.class.name).find(id)
    assert !relation.nil?, "was expecting the #{association.class.name} to NOT have been deleted after deleting an associated #{object.class.name}!"
    
    assert_not relation.send(obj).include?(object), "was expecting the #{association.class.name} to not have retained an orphaned relationship with the deleted #{object.class.name}"
  end

  # ----------------------------------------------------------------------
  def verify_cannot_delete_belongs_to(parent, child)
    prnt = "#{class_name_to_attribute_name(parent.class.name)}"
    
    child.send("#{prnt}=", parent)
    child.save!
    
    assert_raise ActiveRecord::RecordNotDestroyed do
      parent.destroy!
    end
  end
end
