module SessionsHelper

  def log_in
    session_data[user_id] = user.id
  end
end
