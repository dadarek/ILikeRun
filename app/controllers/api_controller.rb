class ApiController < ApplicationController

  skip_before_filter :ensure_is_logged_in

  def get_user_logs
    user_name = params[:user_name]
    if not user_name.nil?
      user = User.where('lower(user_name) = ?', user_name.downcase).first
    end
    logs = user.nil? ? [] : user.run_logs


    render json: logs.to_json(only: [:date_ran, :time_ran])
  end

end
