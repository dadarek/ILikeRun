class RunLogsController < ApplicationController

  def new
    @run_log = RunLog.new
    @run_log.date_ran = Date.today
  end

  def create
    attributes = params[:run_log]
    attributes[:user_id] = current_user.id
    log = RunLog.new(attributes)

    if log.save then
      flash[:notice] = "Your run was succesfully posted!"
      redirect_to action: :new
    else
      @run_log = log
      flash[:alert] = log.errors.full_messages[0]
      render :new
    end

  end

  def index
    user_logs = current_user.run_logs
    @run_logs = user_logs.sort{ |a, b| b.date_ran <=> a.date_ran }
  end

end
