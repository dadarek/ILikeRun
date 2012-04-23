class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
    if @schedule.nil?
      @schedule = Schedule.new
    end
  end

  def destroy
    set_day false
    render nothing: true
  end

  def create
    set_day true
    render nothing: true
  end

  private 
  def set_day value
    day_of_week = params[:day_of_week]
    day_of_week.downcase!
    day_of_week << "="
    current_user.schedule.send(day_of_week, value)
    current_user.schedule.save!
  end

end
