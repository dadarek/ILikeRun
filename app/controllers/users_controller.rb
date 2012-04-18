class UsersController < ApplicationController

  def login 
    if logged_in then
      redirect_to :run_logs
    else
      @user = User.new
    end
  end

  def authenticate
    attributes = params[:user]
    #log = RunLog.new(attributes)

    #if not log.valid? then
    #else
    #  log.save!
    #  flash[:notice] = "Success"
    #end
    user = User.authenticate(attributes[:user_name], attributes[:password])
    if user 
      session[:user_id] = user.id
      redirect_to :root
    else
      flash[:alert] = "Invalid credentials!"
      redirect_to action: :login
    end
  end

  private

  def logged_in
    not session[:user_id].nil? 
  end

end
