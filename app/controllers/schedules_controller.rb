class SchedulesController < ApplicationController

  def index
    @schedule = current_user.schedule
  end

end
