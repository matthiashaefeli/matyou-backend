class ApplicationController < ActionController::Base
  helper_method :user_authenticated

  def user_authenticated
    current_user.active && current_user.admin
  end
end
