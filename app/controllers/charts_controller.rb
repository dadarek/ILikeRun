class ChartsController < ApplicationController

  def index
    @run_logs = current_user.run_logs
    render :index
  end

end
