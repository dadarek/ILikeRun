class RunLogsController < ApplicationController

  def new
    @run_log = RunLog.new
  end

  def create
    attributes = params[:run_log]
    log = RunLog.new(attributes)

    if not log.valid? then
      flash[:alert] = "Error!"
    else
      log.save!
      flash[:notice] = "Success"
    end

    redirect_to action: :new
  end

  def show
    @run_logs = RunLog.all
  end

end
