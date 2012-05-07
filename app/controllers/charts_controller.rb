class ChartsController < ApplicationController

  def index
    user_logs = current_user.run_logs
    two_week_logs = user_logs.where('date_ran > ?', Date.today - 2.weeks)
    ordered_logs = two_week_logs.order("date_ran asc")

    run_logs = ordered_logs
    logs_json = @run_logs.to_json( only: [:date_ran, :time_ran] )
    logs_encoded = URI.encode logs_json

    server = Rails.configuration.charting_server

    @logs_data_url = "#{server}/?#{logs_encoded}"
    render :index
  end

end
