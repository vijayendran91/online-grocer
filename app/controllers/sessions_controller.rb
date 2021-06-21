class SessionsController < ApplicationController
  def new_session
    params.permit(:session_data)
    login_data = params[:session_data]
    user = User.find_by(:phone => login_data[:phone])
    if(user && user.authenticate(login_data[:password]))
      binding.pry
      log_in user
      redirect_to root_path
    else
      redirect_to user_login_path(:status => 403)
    end
  end

  def login
    if params[:status]
      @error = "Password did not match for the given number !"
    end
  end
end
