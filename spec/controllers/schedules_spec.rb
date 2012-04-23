require 'spec_helper'

describe SchedulesController do

  it "returns users schedule" do
    user = create_user
    Schedule.create!( user_id: user.id )

    login user
    get :index
    assigns(:schedule).should == user.schedule
  end

  it "does not return others schedule" do
    u1 = create_user("a", "p")
    u2 = create_user("b", "q")

    Schedule.create! user_id: u1.id 
    Schedule.create! user_id: u2.id

    login u2
    get :index
    assigns(:schedule).should == u2.schedule
  end

end
