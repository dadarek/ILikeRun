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
    end

    context "Retrieving logs" do
      before :each do
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

      def logs_to_json
        @logs.to_json( only: [:id, :date_ran, :time_ran])
      end
    end

    context "Deleting logs" do
      it "renders a success message on good delete" do
        log = create_run_log
        delete :destroy, id: log.id
        response.body.should =~ /Success/
      end

      it "deletes log with given id" do
        log = create_run_log
        delete :destroy, id: log.id
        RunLog.find_by_id(log.id).should be_nil
      end
    end

    context "Adding logs" do
      def make_post date_ran, time_ran
        params = {
          time_ran: time_ran,
          date_ran: date_ran
        }

        post :create, user_name: @user.user_name, run_log: params
      end
      it "adds logs to specified user" do
        make_post(Date.today - 1, 13)
        @user.run_logs.where("date_ran = ? and time_ran = ?", Date.today - 1, 13).count.should == 1
      end

      it "displays a success message on successful add" do
        make_post(Date.today, 11)
        response.body.should =~ /Success/
      end
    end
  end
end
