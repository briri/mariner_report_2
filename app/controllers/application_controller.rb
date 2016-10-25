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
  def is_authorized?(policy_name)
    logged_in?
    
    unless current_user.has_authority?(policy_name)
      redirect_to root_path, notice: 'You are not authorized to perform that action!' 
    end
  end
end
