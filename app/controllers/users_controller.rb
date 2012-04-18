class UsersController < ApplicationController

  def login 
    @user = User.new
  end

  def authenticate
    attributes = params[:user]
    #log = RunLog.new(attributes)

    #if not log.valid? then
    #else
    #  log.save!
    #  flash[:notice] = "Success"
    #end
    if User.authenticate(attributes[:user_name], attributes[:password]) then
      redirect_to :root
    else
      flash[:alert] = "Invalid credentials!"
      redirect_to action: :login
    end
  end

end
