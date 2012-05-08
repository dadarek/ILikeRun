class ChartsController < ApplicationController

  def index
    user_logs = current_user.run_logs
    two_week_logs = user_logs.where('date_ran > ?', Date.today - 2.weeks)
    ordered_logs = two_week_logs.order("date_ran asc")
    logs_json = ordered_logs.to_json( only: [:date_ran, :time_ran] )
    json_encoded = URI.encode logs_json

    server = Rails.configuration.charting_server

    @logs_data_url = "#{server}/?#{json_encoded}"

    begin
      @chart_data_points = HTTParty.get "http://0.0.0.0:8858/x"
    rescue
      redirect_to action: "unavailable"
    else
      render :index
    end
  end

  def unavailable
  end

end
