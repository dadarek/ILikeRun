class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
    if @schedule.nil?
      @schedule = Schedule.new
    end
  end

  def destroy
    current_user.schedule.monday = false
    current_user.schedule.save!

    render nothing: true
  end

  def create
    current_user.schedule.tuesday = true
    current_user.schedule.save!

    render nothing: true
  end

end
