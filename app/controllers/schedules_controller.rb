class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
    if @schedule.nil?
      @schedule = Schedule.new
    end
  end

  def destroy
    day_of_week = params[:day_of_week]
    day_of_week.downcase!
    day_of_week << "="
    current_user.schedule.send(day_of_week, false)
    current_user.schedule.save!

    render nothing: true
  end

  def create
    day_of_week = params[:day_of_week]
    day_of_week.downcase!
    day_of_week << "="
    current_user.schedule.send(day_of_week, true)
    current_user.schedule.save!

    render nothing: true
  end

end
