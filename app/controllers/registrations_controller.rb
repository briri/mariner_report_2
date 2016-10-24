class RegistrationsController < Devise::RegistrationsController

  # PUT /registrations
  # ---------------------------------------------------------
  def update
    redirect_to root_path, alert: "You are not authorized to do that!"
  end
  
  # POST /registrations
  # ---------------------------------------------------------
  def create
  	existing_user = User.find_by_email(sign_up_params[:email])
  	if !existing_user.nil? then
  		redirect_to after_sign_up_error_path_for(resource), alert: "That email address has already been registered!"
    else
			super
		end
  end
  
  # DELETE /registrations
  # ---------------------------------------------------------
  def destroy
    redirect_to root_path, alert: "You are not authorized to do that!"
  end
end