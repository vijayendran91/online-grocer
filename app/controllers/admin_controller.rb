class AdminController < ApplicationController
  def admin_home
    @is_admin_logged_in = is_admin_logged_in?
  end

  def item_list
    
  end
end
