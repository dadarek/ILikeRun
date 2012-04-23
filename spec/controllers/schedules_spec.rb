require 'spec_helper'

describe SchedulesController do

  it "returns users schedule" do
    create_user
    login
    Schedule.create!( user_id: @user.id )
    get :index
    assigns(:schedule).should == @user.schedule
  end

end
