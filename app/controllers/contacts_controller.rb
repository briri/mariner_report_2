class ContactsController < ApplicationController
  
  # GET /contacts/
  # -----------------------------------------------------------
  def index
    # If user is not admin then redirect to new
    redirect_to new_contact_path
  end
  
  # GET /contacts/new
  # -----------------------------------------------------------
  def new
    @contact = (current_user ? Contact.new(name: current_user.name, 
                                           email: current_user.email) : Contact.new)
  end
  
  # POST /contacts
  # -----------------------------------------------------------
  def create
    puts "PARAMS: #{params[:contact].inspect}"
    
    @contact = Contact.new(contact_params)
    
    if @contact.save
      render 'confirmation'
    else
      render :new
    end
    
  end
  
  
  private
    # -----------------------------------------------------------
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end

end