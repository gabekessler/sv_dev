class AuthenticationsController < ApplicationController
  
  def index
    @authentications = current_user.authentications if current_user
  end

  def create
    omniauth = request.env["omniauth.auth"]
    logger.debug "OMNI ------- #{omniauth.to_yaml}"
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    logger.debug "AUTH ------- #{authentication.to_yaml}"
    if authentication
      flash[:notice] = "Signed in successfully."
      sign_in_and_redirect(:user, authentication.user)
    elsif current_user
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to authentications_url
    else
      user = User.new
      user.apply_omniauth(omniauth)
      if user.save
        flash[:notice] = "Signed in successfully."
        redirect_to authentication_add_friends_url(user)
      else
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
