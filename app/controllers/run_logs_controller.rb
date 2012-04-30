class RunLogsController < ApplicationController

  def new
    @run_log = RunLog.new
    @run_log.date_ran = Date.today
  end

  def create
    @run_log = create_log_from_params

    if @run_log.save then
      flash[:notice] = "Your run was succesfully posted!"
      redirect_to :new_run_log
    else
      flash[:alert] = @run_log.errors.full_messages[0]
      render :new
    end

  end

  def index
    user_logs = current_user.run_logs
    @run_logs = user_logs.sort{ |a, b| b.date_ran <=> a.date_ran }
  end

  def destroy
    log = RunLog.find_by_id params[:id]
    log.destroy if not log.nil?

    redirect_to :run_logs
  end

  private

  def create_log_from_params
    attributes = params[:run_log]
    attributes[:user_id] = current_user.id
    RunLog.new(attributes)
  end

end
