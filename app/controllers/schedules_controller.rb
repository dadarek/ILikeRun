class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
    if @schedule.nil?
      @schedule = Schedule.new
    end
  end

  def destroy
    if not current_user.schedule.nil?
      current_user.schedule.monday = false
      current_user.schedule.save!
    end
    render nothing: true
  end

end
