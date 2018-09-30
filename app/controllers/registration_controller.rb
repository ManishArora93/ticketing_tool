class RegistrationController < Devise::RegistrationsController
    
   # Public: /users/sign_up New user sign up 
	def new
		@user=User.new
	end   
  # Public:POST
  #
  # Params:The form params 
  #
  # Redirect to new_user_session_path
  #
  #render new 
	def create    
    @user= User.new(user_params)
    @user.role_id = 2
    if @user.errors.blank?
      @user.save
      flash[:success]="Welcome to CrossOver Customer Support"
      redirect_to new_user_session_path
    else
      render 'new'  
    end     
  end
  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
