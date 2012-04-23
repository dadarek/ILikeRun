class SchedulesController < ApplicationController

  def index
    @schedule = Schedule.first
  end

end
