module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, uniqueness: true
    
    def name=(value)    
      #name = value
      write_attribute :name, value
      
      unless value.nil? or value.empty?
        #@slug = value.downcase.gsub(/[^0-9a-z\s]/i, '').gsub(/\s/, '-')
        write_attribute :slug, value.downcase.gsub(/[^0-9a-z\s]/i, '').gsub(/\s/, '-')
      end
    end
  end

  module ClassMethods
    
  end
end
