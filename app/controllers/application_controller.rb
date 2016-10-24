class ApplicationController < ActionController::Base
  include Pundit
  
  protect_from_forgery with: :exception, prepend: true
  
  # -------------------------------------------------------
  def logged_in?
    unless user_signed_in?
      redirect_to root_path, notice: 'You are not authorized to perform that action!' 
    end
  end
  
  # -------------------------------------------------------
  def is_admin?
    user_signed_in? && user.roles.include?(1)
  end
end
