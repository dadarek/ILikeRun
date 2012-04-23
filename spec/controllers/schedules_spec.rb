require 'spec_helper'

describe SchedulesController do

  before :each do
    @user = create_user
    login @user
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
      @user.schedule.monday = true
      @user.schedule.saturday = true
      @user.schedule.save!

      delete :destroy, day_of_week: "Monday"
      delete :destroy, day_of_week: "Saturday"
      @user.reload
      @user.schedule.monday.should == false
      @user.schedule.saturday.should == false
    end

    it "redirects to schedule page" do
      delete(:destroy, day_of_week: "Monday").should redirect_to :schedules
    end
  end

  describe "#create" do
    it "sets not-running days to yes-running days" do
      post :create, day_of_week: "Tuesday"
      post :create, day_of_week: "Wednesday"
      @user.reload
      @user.schedule.tuesday.should == true
      @user.schedule.wednesday.should == true
    end

    it "redirects to schedule page" do
      post(:create, day_of_week: "Monday").should redirect_to :schedules
    end
  end
end
