class ChartsController < ApplicationController

  def index
    user_logs = current_user.run_logs
    two_week_logs = user_logs.where('date_ran > ?', Date.today - 2.weeks)
    ordered_logs = two_week_logs.order("date_ran asc")

    @run_logs = ordered_logs
    render :index
  end

end
