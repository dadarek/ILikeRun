class ChartsController < ApplicationController

  def index
    two_weeks_ago = Date.today - 2.weeks
    @run_logs = current_user.run_logs.where('date_ran > ?', two_weeks_ago)
    render :index
  end

end
