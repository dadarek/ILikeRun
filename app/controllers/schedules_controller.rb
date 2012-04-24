class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
  end

  def destroy
    set_day_of_week false
    redirect_to :schedules
  end

  def create
    set_day_of_week true
    redirect_to :schedules
  end

  private 
  def set_day_of_week value
    schedule = current_user.schedule
    schedule.send(day_of_week_as_symbol, value)
    schedule.save!
  end

  def day_of_week_as_symbol
    day_of_week = params[:day_of_week]
    day_of_week.downcase!
    day_of_week << "="
    day_of_week
  end

end
