class RunLogsController < ApplicationController

  def index
  end

  def create
    log = RunLog.new
    log.time_ran = params[:time_ran]

    if not log.valid? then
      redirect_to root_path, notice: 'ERROR'
    else
      log.save!
      redirect_to root_path
    end
  end

end
