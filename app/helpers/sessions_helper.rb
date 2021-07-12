module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id.to_s
  end

  def current_user
    if session[:user_id]
      @current_user = User.find_by(:id => session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin_logged_in?
    result = false
    if logged_in?
      user = current_user
      User::USER_PERMISSIONS.each do |permission|
        if user.permission.include? permission
          result = true
        end
      end
    end
    result
  end
end
