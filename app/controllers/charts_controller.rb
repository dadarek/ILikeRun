class ChartsController < ApplicationController

  def index
    begin
      @chart_data_points = get_chart_data_points
    rescue
      flash[:alert] = 'An error occured while contacting the charting server.'
      redirect_to action: "unavailable"
    else
      render :index
    end
  end

  private

  def get_chart_data_points
    server = Rails.configuration.charting_server
    logs_data_url = "#{server}/?#{uri_encoded_json_logs}"
    HTTParty.get logs_data_url
  end

  def uri_encoded_json_logs
    logs_json = user_logs_from_last_2_weeks.to_json( only: [:date_ran, :time_ran] )
    URI.encode logs_json
  end

  def user_logs_from_last_2_weeks
    current_user.run_logs.where('date_ran > ?', Date.today - 2.weeks)
  end

end
