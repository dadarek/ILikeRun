class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_is_logged_in
  helper_method :current_user

  def ensure_is_logged_in
    redirect_to :users_login if not current_user 
  end

  def current_user
    User.find_by_id session[:user_id]
  end

  def logged_in user
    session[:user_id] = user.id
  end

  def logged_out
    session[:user_id] = nil
  end

end
