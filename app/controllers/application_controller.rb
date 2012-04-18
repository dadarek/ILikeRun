class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :ensure_is_logged_in

  def ensure_is_logged_in
  end

end
