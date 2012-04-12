require 'spec_helper'

describe RunLogsController do

  describe "#create" do

    context "a valid post" do
      before :each do
        @time_ran = 30
        post :create, time_ran: @time_ran
      end

      it "creates a RunLog with correct time_ran" do
        RunLog.first.time_ran.should == @time_ran
      end

      it "creates a RunLog with correct date" do
        RunLog.first.created_at.to_date.should == Date.today
      end

      it "stores success message in flash" do
        flash.now[:notice].should_not be_nil
      end

    end

    context "an INVALID post" do
      before :each do
        post :create, time_ran: -1
      end

      it "stores an error in flash" do
        flash.now[:alert].should_not be_nil
      end
    end

  end
end
