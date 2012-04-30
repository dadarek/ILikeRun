class ApiController < ApplicationController

  skip_before_filter :ensure_is_logged_in

  def get_user_logs
    render nothing: true
  end

end
