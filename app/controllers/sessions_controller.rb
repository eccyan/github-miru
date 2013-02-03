class SessionsController < ApplicationController
  def callback
    auth = request.env["omniauth.auth"]
    @authentication = Authentication.find_by_provider_and_uid(auth["provider"], auth["uid"])
    user = @authentication.try(:user)

    if user
      user.name = auth[:info][:nickname]
      user.save
      session[:user_id] = user.id
    else
      user = User.new(name: auth[:info][:nickname])
      user.save

      Authentication.create_with_omniauth(user, auth)
      @authentication = Authentication.find_by_provider_and_uid(auth["provider"], auth["uid"])
      session[:user_id] = user.id
    end

    @authentication.delay.update_sources @authentication

    redirect_to user, :notice => "Welcome #{auth["name"]} !!"
  end

  def destroy  
    session[:user_id] = nil  
    redirect_to root_path, :notice => "Logout."  
  end  
end
