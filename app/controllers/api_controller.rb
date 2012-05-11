class ApiController < ApplicationController

  skip_before_filter :ensure_is_logged_in

  def get_user_logs
    user = User.find_by_user_name(params[:user_name])
    logs = user.nil? ? [] : user.run_logs

    render json: logs.to_json(only: [:id, :date_ran, :time_ran])
  end

end
