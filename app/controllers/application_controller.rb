class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_is_logged_in

  def ensure_is_logged_in
    redirect_to :users_login if session[:user_id].nil?
  end

  def current_user
    User.find_by_id session[:user_id]
  end

end
