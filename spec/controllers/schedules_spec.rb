require 'spec_helper'

describe SchedulesController do

  before :each do
    @user = create_user
    login @user
  end

  describe "#index" do

    def create_schedule user
      Schedule.create!( user_id: user.id )
    end

    it "returns users schedule" do
      create_schedule @user
      get :index
      assigns(:schedule).should == @user.schedule
    end

    it "does not return others schedule" do
      u2 = create_user("b", "q")

      create_schedule u2
      create_schedule @user

      get :index
      assigns(:schedule).should == @user.schedule
    end

    it "assigns blank schedule if none exists" do
      get :index
      assigns(:schedule).should be_instance_of(Schedule)
    end

    pending "all users should have a schedule"
  end

  describe "#delete" do
    
    it "sets yes-running days to not-running days" do
      schedule = Schedule.create!(user_id: @user.id)
      schedule.monday = true

      delete :destroy, day_of_week: "Monday"
      schedule.reload
      schedule.monday.should == false
    end

  end

end
