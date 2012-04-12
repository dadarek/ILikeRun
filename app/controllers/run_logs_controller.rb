class RunLogsController < ApplicationController

  def index
  end

  def create
    log = RunLog.new
    log.time_ran = params[:time_ran]

    if not log.valid? then
      redirect_to root_path, alert: 'ERROR'
    else
      log.save!
      redirect_to root_path, notice: "Success!"
    end
  end

end
