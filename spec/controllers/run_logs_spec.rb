require 'spec_helper'

describe RunLogsController do

  describe "#new" do
    it "initializes @run_log to an dummy instance" do
      get :new
      assigns(:run_log).should_not be_nil
    end
  end

  describe "#create" do
    context "a valid post" do
      before :each do
        @params = { time_ran: 30 }
        post :create, run_log: @params
      end

      it "creates a RunLog with correct time_ran" do
        RunLog.first.time_ran.should == @params[:time_ran] 
      end

      it "creates a RunLog with correct date" do
        RunLog.first.created_at.to_date.should == Date.today
      end

      it "stores success message in flash" do
        flash.now[:notice].should_not be_nil
      end

    end

    context "an INVALID post" do
      it "stores an error in flash" do
        post :create, run_log: {time_ran: -1}
        flash.now[:alert].should_not be_nil
      end
    end
  end

  describe "show" do
    it "initializes @run_logs to all instances of run_logs in the database." do
      RunLog.create!(time_ran: 30)
      RunLog.create!(time_ran: 30)
      get :show
      assigns(:run_logs).should == RunLog.all
    end
  end

end
