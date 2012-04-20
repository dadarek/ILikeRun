class UsersController < ApplicationController

  skip_before_filter :ensure_is_logged_in

  def login 
    redirect_to :new_run_log if current_user
  end

  def logout
    logged_out
    redirect_to :root
  end

  def authenticate
    attributes = params[:user]
    user = User.authenticate(attributes[:user_name], attributes[:password])

    if user 
      logged_in user
      redirect_to :new_run_log
    else
      flash[:alert] = "Invalid credentials!"
      redirect_to action: :login
    end
  end

end
