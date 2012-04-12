require 'spec_helper'

describe RunLogsController do

  describe "#create" do

    context "a valid post" do
      before :each do
        @time_ran = 30
        post :create, time_ran: @time_ran
      end

      it "redirects to home page" do
        response.should redirect_to root_path
      end

      it "creates a RunLog with correct time_ran" do
        RunLog.first.time_ran.should == @time_ran
      end

      it "creates a RunLog with correct date" do
        RunLog.first.created_at.to_date.should == Date.today
      end
    end

    context "an INVALID post" do
      it "should not redirect" do
        post :create, time_ran: -1
        response.should redirect_to root_path
      end

      it "stores an error in flash" do
        post :create, time_ran: -1
        flash.now[:notice].should_not be_nil
      end
    end

  end
end
