require 'spec_helper'

describe RunLogsController do

  describe "#create" do
    before :each do
      @time_ran = 30
      post :create, time_ran: @time_ran
    end

    it "should redirect to home page" do
      response.should redirect_to root_path
    end

    it "creates a Runlog" do
      RunLog.first.time_ran.should == @time_ran
    end

  end

end
