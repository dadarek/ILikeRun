class ChartsController < ApplicationController

  def index
    user_logs = current_user.run_logs
    two_week_logs = user_logs.where('date_ran > ?', Date.today - 2.weeks)
    logs_json = two_week_logs.to_json( only: [:date_ran, :time_ran] )
    json_encoded = URI.encode logs_json

    server = Rails.configuration.charting_server

    logs_data_url = "#{server}/?#{json_encoded}"

    begin
      @chart_data_points = HTTParty.get logs_data_url
    rescue
      flash[:alert] = 'An error occured while contacting the charting server.'
      redirect_to action: "unavailable"
    else
      render :index
    end
  end

end
