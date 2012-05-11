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

    it "does not crash on invalid delete id" do
      get :delete, id: 0
    end

    it "renders record not found message on invalid delete" do
      get :delete, id: 0
      response.body.should =~ /not found/
    end

  end

  context "Valid requests" do

    before :each do
      user = create_user("Bob")
      @log1 = RunLog.create!(time_ran: 50, date_ran: Date.today, user_id: user.id)
      @log2 = RunLog.create!(time_ran: 24, date_ran: Date.today - 3.days, user_id: user.id)
      @logs = [@log1, @log2]
    end
    
    it "sends back given users logs" do
      get :get_user_logs, user_name: "Bob"
      response.body.should == logs_to_json
    end

    it "ignores case" do
      get :get_user_logs, user_name: "bob"
      response.body.should == logs_to_json
    end

    it "renders a success message on good delete" do
      get :delete, id: @log1.id
      response.body.should =~ /Success/
    end

    it "deletes log with given id" do
      get :delete, id: @log1.id
      RunLog.find_by_id(@log1.id).should be_nil
    end

    def logs_to_json
      @logs.to_json( only: [:id, :date_ran, :time_ran])
    end

  end

end
