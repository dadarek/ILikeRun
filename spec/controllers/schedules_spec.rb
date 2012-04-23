require 'spec_helper'

describe SchedulesController do

  it "returns users schedule" do
    create_user
    Schedule.create!( user_id: @user.id )

    login
    get :index
    assigns(:schedule).should == @user.schedule
  end

  it "does not return others schedule" do
    create_user("a", "p")
    u1 = @user
    create_user("b", "q")
    u2 = @user

    Schedule.create! user_id: u1.id 
    Schedule.create! user_id: u2.id

    login
    get :index
    assigns(:schedule).should == @user.schedule
  end

end
