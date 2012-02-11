class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    # GETS FEED AND LOOKS FOR EXISTING AUTHENTICATION
    omniauth = request.env["omniauth.auth"]
    logger.debug "OMNI ------- #{omniauth.to_yaml}"
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    logger.debug "AUTH ------- #{authentication.to_yaml}"
    if authentication
      # IF AUTHENTICATION IS FOUND, LOG IN USING ITS USER
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      # IF SOMEONE IS ALREADY LOGGED IN BUT DOESN'T HAVE AN AUTHENTICATION. CREATE ONE
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      # IF NO AUTHENTICATION AND NO ONE LOGGED IN
      # CREATE NEW USER AND PROFILE
      # UPDATE USER AND PROFILE ATTRIBUTES USING OMNIAUTH FEED ATTRIBUTES
      # SIGN IN WITH USER
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        @profile = Profile.create(:user_id => user.id)
        user.update_with_omniauth(omniauth)
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, user)
      else
        # IF UNSUCCESSFUL USER#CREATE SEND TO SIGN UP FORM FOR FIXIN
        session[:omniauth] = omniauth
        redirect_to new_user_registration_url
      end
    end
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
  
  def add_friends
  end
  
end
