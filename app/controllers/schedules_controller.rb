class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
    if @schedule.nil?
      @schedule = Schedule.new
    end
  end

end
