require 'spec_helper'

describe ApiController do

  it "allows unauthenticated users" do
    (get :get_user_logs).should_not be_redirect
  end

  it "sends back empty json on invalid user" do
    get :get_user_logs
    response.body.should == [].to_json
  end

  it "sends back given users logs" do
    user = create_user("Bob")
    RunLog.create!(time_ran: 50, date_ran: Date.today, user_id: user.id)
    get :get_user_logs, user_name: "Bob"
    response.body.should == user.run_logs.to_json( only: [:date_ran, :time_ran])
  end

end
