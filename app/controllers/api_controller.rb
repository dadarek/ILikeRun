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
    user_name = params[:user_name]

    user = User.find_by_user_name user_name
    if user.nil?
      render text: "User with user name #{user_name} not found."
    else
      attributes = params[:run_log]
      attributes[:user_id] = user.id
      log = RunLog.new(attributes)
      if log.save
        render nothing: true
      else
        render text: "Invalid date."
      end
    end
  end
end
