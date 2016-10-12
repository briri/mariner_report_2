class CategoryType < ApplicationRecord
  has_many :categories
  
  # -----------------------------------
  validates :name, uniqueness: true
  validates :name, presence: true
  
  # -----------------------------------
  before_destroy :check_for_categories
  
  private
    # Prevent a CategoryType with associated Categories from being deleted
    # ----------------------------------------------------------------------
    def check_for_categories
      throw :abort unless Category.where(category_type: self).empty?
    end
end