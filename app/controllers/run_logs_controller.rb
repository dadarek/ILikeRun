class RunLogsController < ApplicationController

  def index
  end

  def create
    time_ran = params[:time_ran]
    RunLog.create!( time_ran: time_ran )
    redirect_to action: :index
  end

end
