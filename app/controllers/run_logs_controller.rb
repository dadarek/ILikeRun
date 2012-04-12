class RunLogsController < ApplicationController

  def show 
  end

  def create
    log = RunLog.new
    log.time_ran = params[:time_ran]

    if not log.valid? then
      flash[:alert] = "Error!"
    else
      log.save!
      flash[:notice] = "Success"
    end

    redirect_to action: :show
  end

end
