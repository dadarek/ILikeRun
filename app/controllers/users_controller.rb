class UsersController < ApplicationController

  skip_before_filter :ensure_is_logged_in

  def login 
    if logged_in then
      redirect_to :new_run_log
    end
  end

  def logout
    redirect_to :root
  end

  def authenticate
    attributes = params[:user]
    user = User.authenticate(attributes[:user_name], attributes[:password])

    if user 
      session[:user_id] = user.id
      redirect_to :new_run_log
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
