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
    try_create_log
    if @error_message.nil?
      render nothing: true
    else
      render text: @error_message
    end
  end

  private

  def try_create_log
    user = find_user
    return if user.nil?

    log = create_log user
    if !log.save
      @error_message = log.errors.full_messages
    end
  end

  def find_user
    user_name = params[:user_name]
    user = User.find_by_user_name user_name
    if user.nil?
      @error_message = "User with user name #{user_name} not found."
    end
    user
  end

  def create_log(user)
    attributes = params[:run_log]
    attributes[:user_id] = user.id
    RunLog.new attributes
  end
end
