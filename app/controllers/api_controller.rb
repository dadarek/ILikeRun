class ApiController < ApplicationController
  skip_before_filter :ensure_is_logged_in

  def get_user_logs
    user = User.find_by_user_name(params[:user_name])
    logs = user.nil? ? [] : user.run_logs

    render json: logs.to_json(only: [:id, :date_ran, :time_ran])
  end

  def destroy
    log = RunLog.find_by_id params[:id]
    if log.nil?
      render text: "Log with id #{params[:id]} was not found."
    else
      log.destroy
      render text: "Success"
    end
  end

  def create
    user = User.find_by_user_name(params[:user_name])
    attributes = params[:run_log]
    attributes[:user_id] = user.id
    RunLog.create!(attributes)
    render nothing: true
  end
end
