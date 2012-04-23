require 'spec_helper'

describe SchedulesController do

  before :each do
    @user = create_user
    login @user
    @schedule = @user.schedule
  end

  describe "#index" do

    it "returns users schedule" do
      get :index
      assigns(:schedule).should == @user.schedule
    end

    it "does not return others schedule" do
      u2 = create_user("b", "q")
      login u2

      get :index
      assigns(:schedule).should == u2.schedule
    end

  end

  describe "#delete" do
    it "sets yes-running days to not-running days" do
      @schedule.monday = true
      @schedule.saturday = true

      delete :destroy, day_of_week: "Monday"
      delete :destroy, day_of_week: "Saturday"
      @schedule.reload
      @schedule.monday.should == false
      @schedule.saturday.should == false
    end

    it "redirects to schedule page" do
      delete(:destroy, day_of_week: "Monday").should redirect_to :schedules
    end
  end

  describe "#create" do
    it "sets not-running days to yes-running days" do
      post :create, day_of_week: "Tuesday"
      post :create, day_of_week: "Wednesday"
      @schedule.reload
      @schedule.tuesday.should == true
      @schedule.wednesday.should == true
    end

    it "redirects to schedule page" do
      post(:create, day_of_week: "Monday").should redirect_to :schedules
    end
  end
end
