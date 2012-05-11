require 'spec_helper'

describe ApiController do
  context "Miscellaneous" do
    it "allows unauthenticated users" do
      (get :get_user_logs).should_not be_redirect
    end

    it "sends back empty json on invalid user" do
      get :get_user_logs
      response.body.should == [].to_json
    end

    it "renders record not found message on invalid delete" do
      delete :destroy, id: 0
      response.body.should =~ /not found/
    end

    it "provides error message on invalid user when adding" do
      params = {
        time_ran: 88,
        date_ran: Date.today
      }

      post :create, user_name: 'invalid_user_name', run_log: params
      response.body.should =~ /not found/
    end

    it "provides error message on invalid date ran when adding" do
      user = create_user
      params = {
        time_ran: 88,
        date_ran: Date.today + 1
      }

      post :create, user_name: user.user_name, run_log: params
      response.body.should =~ /Date ran/
    end

    it "provides error message on invalid time ran when adding" do
      user = create_user
      params = {
        time_ran: -1,
        date_ran: Date.today
      }

      post :create, user_name: user.user_name, run_log: params
      response.body.should =~ /Time ran/
    end
  end

  context "Valid requests" do
    before :each do
      @user = create_user
      @log1 = create_run_log(Date.today, 50)
      @log2 = create_run_log(Date.today - 3.days, 24)
      @logs = [@log1, @log2]
    end
    
    it "sends back given users logs" do
      get :get_user_logs, user_name: @user.user_name
      response.body.should == logs_to_json
    end

    it "ignores case" do
      get :get_user_logs, user_name: @user.user_name
      response.body.should == logs_to_json
    end

    it "renders a success message on good delete" do
      delete :destroy, id: @log1.id
      response.body.should =~ /Success/
    end

    it "deletes log with given id" do
      delete :destroy, id: @log1.id
      RunLog.find_by_id(@log1.id).should be_nil
    end

    it "adds logs to specified user" do
      el_date = Date.today
      params = {
        time_ran: 88,
        date_ran: el_date
      }

      post :create, user_name: @user.user_name, run_log: params
      @user.run_logs.where("time_ran = ? and date_ran = ?", 88, el_date).count.should == 1
    end

    it "displays a success message on successful add" do
      el_date = Date.today
      params = {
        time_ran: 88,
        date_ran: el_date
      }

      post :create, user_name: @user.user_name, run_log: params
      @user.run_logs.where("time_ran = ? and date_ran = ?", 88, el_date).count.should == 1
      response.body.should =~ /Success/
    end

    def logs_to_json
      @logs.to_json( only: [:id, :date_ran, :time_ran])
    end
  end
end
