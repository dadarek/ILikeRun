class RunLogsController < ApplicationController

  def new
  end

  def create
    attributes = params[:run_log]
    attributes[:user_id] = current_user.id
    log = RunLog.new(attributes)

    if not log.valid? then
      flash[:alert] = "Oh No!!! An error occured while trying to save your run!"
    else
      log.save!
      flash[:notice] = "Your run was succesfully posted!"
    end

    redirect_to action: :new
  end

  def index
    @run_logs = RunLog.all(order: "created_at desc")
  end

end
