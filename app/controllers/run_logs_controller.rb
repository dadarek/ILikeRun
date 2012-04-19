class RunLogsController < ApplicationController

  def new
  end

  def create
    attributes = params[:run_log]
    attributes[:user_id] = current_user.id
    log = RunLog.new(attributes)

    if log.save then
      flash[:notice] = "Your run was succesfully posted!"
    else
      flash[:alert] = "Oh No!!! An error occured while trying to save your run!"
    end

    redirect_to action: :new
  end

  def index
    user_logs = current_user.run_logs
    @run_logs = user_logs.sort{ |a, b| b.created_at <=> a.created_at }
  end

end
