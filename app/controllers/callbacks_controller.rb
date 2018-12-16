class CallbacksController < Devise::OmniauthCallbacksController 
  def omniauth_all
    @user = User.from_omniauth(request.env["omniauth.auth"]) 
    if @user && @user.persisted? 
      sign_in_and_redirect @user, event: :authentication
    else
      flash[:notice] = 'User with this email already exists'
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :omniauth_all
  alias_method :github, :omniauth_all

  def failure
    redirect_to root_path
  end
end