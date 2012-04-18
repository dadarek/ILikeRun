class UsersController < ApplicationController

  def login 
    @user = User.new
  end

  def authenticate
    #attributes = params[:run_log]
    #log = RunLog.new(attributes)

    #if not log.valid? then
      flash[:alert] = "Error!"
    #else
    #  log.save!
    #  flash[:notice] = "Success"
    #end
    redirect_to action: :login
  end

end
