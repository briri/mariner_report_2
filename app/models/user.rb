class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, 
         :rememberable, :trackable, :validatable
         
  has_many :user_policies
  has_many :policies, through: :user_policies

  validates :email, uniqueness: true
  
  def has_authority?(policy_name)
    !self.policies.where(name: policy_name).empty?
  end
end