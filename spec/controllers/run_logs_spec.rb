require 'spec_helper'

describe RunLogsController do

  before :each do
    @user = create_user
    login @user
  end

  describe "#create" do
    context "a valid post" do
      before :each do
        @params = { time_ran: 30, date_ran: Date.today - 10.days }
      end

      def make_post
        post :create, run_log: @params
      end

      it "creates a RunLog with correct time_ran" do
        make_post
        RunLog.first.time_ran.should == @params[:time_ran] 
      end

      it "creates a RunLog with correct date" do
        make_post
        RunLog.first.date_ran.to_date.should == @params[:date_ran]
      end

      it "stores success message in flash" do
        make_post
        flash.now[:notice].should_not be_nil
      end

      it "associates run logs with new users" do
        make_post
        @user.run_logs.count.should == 1
      end

      it "redirects to new" do
        make_post.should redirect_to(action: :new)
      end

    end

    context "an INVALID post" do
      def params
        {time_ran: -1, date_ran: Date.today + 1}
      end
      def make_post
        post :create, run_log: params
      end
      
      it "stores an error in flash" do
        make_post
        bad_log = RunLog.create(time_ran: -1)
        flash.now[:alert].should == bad_log.errors.full_messages[0]
      end

      it "renders new" do
        make_post.should render_template(:new)
      end
      
      it "stores posted value in @run_log" do
        make_post
        assigns[:run_log].date_ran.should == params[:date_ran]
        assigns[:run_log].time_ran.should == params[:time_ran]
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
      assigns(:run_logs).should =~ @user.run_logs
    end

    it "sorts the run logs in reverse-chronological order" do
      get :index
      logs = assigns(:run_logs)
      logs[0].should == @today 
      logs[1].should == @yesterday
      logs[2].should == @three_days_ago 
    end

    it "only returns logged-in users logs" do
      other_user = User.create!( user_name: "John Smith", password: "apple" )
      log = RunLog.create!(time_ran: 55, date_ran: Date.today, user_id: other_user.id)

      get :index
      logs = assigns(:run_logs)
      logs.should_not include(log)
    end
  end

  describe "#new" do
    it "initializes date_ran to todays date" do
      get :new
      assigns[:run_log].date_ran.should == Date.today
    end
  end

  describe "#destroy" do
    it "deletes posted log" do
      log = new_log(15, Date.today)
      delete :destroy, id: log
      RunLog.find_by_id(log.id).should be_nil
    end

    it "doesn't crash on invalid id" do
      delete :destroy, id: -1
    end
  end

  def new_log(time_ran, date_ran)
    result = RunLog.create!(time_ran: 20, date_ran: date_ran, user_id: @user.id)
    result.save
    result
  end
end
