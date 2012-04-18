class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_is_logged_in

  def ensure_is_logged_in
    redirect_to :users_login if session[:user_id].nil?
  end

end
