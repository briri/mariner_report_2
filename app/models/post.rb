class Post < ApplicationRecord
  include Sluggable
  
  before_save :prepend_date_to_slug
  
  belongs_to :user
  
  has_many :comments
  has_many :post_tags, dependent: :delete_all
  has_many :tags, through: :post_tags
  
  scope :active, -> { where(active: true) }
  
  # --------------------------------------------------
  def content
    val = (super.nil? ? "" : super.gsub('\n', '<br />'))
    
    (val.start_with?('<') ? val : "<p>#{val}</p>")
  end
  
  # --------------------------------------------------
  def self.find_by_path(year, month, day, title)
    Post.active.find_by(slug: "#{year}-#{month}-#{day}-#{title}")
  end
  
  # ==================================================
  private
    # We want the slug to be unique but cannot expect the post's name to be 
    # unique, so prepend the date to the slug
    def prepend_date_to_slug
      now = Date.today
      post = Post.where(slug: self.slug)
      self.slug = "#{now.year}-#{now.month}-#{now.day}-#{slug}".slice(0, 254) 
    end

end