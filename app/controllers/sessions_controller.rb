class SessionsController < ApplicationController
  def verify_creds
    params.permit(:session_data)
    login_data = params[:session_data]
    begin
      user = User.find_by(:phone => login_data[:phone])
      auth = user.authenticate(login_data[:password])
      unless auth.nil?
        redirect_to user_verify_otp_path(:phone => user.phone)
      else
        raise Exceptions::PasswordMismatch.new("Password did not match for the given phone number !")
      end
    rescue Exceptions::PasswordMismatch => e
      redirect_to user_login_path(:error => e.error_msg)
    rescue Mongoid::Errors::DocumentNotFound => e
      redirect_to user_login_path(:error => "Phone number not found !")
    end
  end

  def verify_otp
    if request.get?
      if !params[:phone].nil?
        begin
          @user = User.find_by(:phone => params[:phone])
          response = TwoFactor.send_passcode(params[:phone])
          @user.update({:otp_session => response["Details"]})
          respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @user }
          end
        rescue => error
          redirect_to root_path
        end
      elsif !params[:sign_up_data][:phone].nil?
        params.permit(:sign_up_data)
        @user = User.find_by(:phone => params[:sign_up_data][:phone])
        response = TwoFactor.send_passcode(params[:sign_up_data][:phone])
        @user.update({:otp_session => response["Details"]})
        respond_to do |format|
          format.html # show.html.erb
          format.json { render json: @user }
        end
      end
    elsif request.post?
      params.permit(:session_data)
      otp = params[:session_data][:otp]
      user = User.find_by(:phone => params[:session_data][:phone])
      verification_response = TwoFactor.verify_passcode(user[:otp_session], otp)
      log_in user
      redirect_to root_path
    end
  end

    # log_in user

  def login
    if params[:error]
      @error = params[:error]
    end
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_path
  end
end
