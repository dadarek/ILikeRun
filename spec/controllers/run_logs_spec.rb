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

  describe "#index" do
    before :each do
      @yesterday = new_log(40, Date.today - 1.day)
      @today = new_log(20, Date.today)
      @three_days_ago = new_log(30, Date.today - 3.day)
    end

    it "initializes @run_logs to all instances of run_logs in the database." do
      get :index
      assigns(:run_logs).should =~ RunLog.all
    end

    it "sorts the run logs in reverse-chronological order" do
      get :index
      logs = assigns(:run_logs)
      logs[0].should == @today 
      logs[1].should == @yesterday
      logs[2].should == @three_days_ago 
    end

    def new_log(time_ran, day)
      result = RunLog.create!(time_ran: 20)
      result.created_at = day
      result.save
      result
    end
  end

end
