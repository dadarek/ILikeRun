require 'spec_helper'

describe ApiController do

  it "allows unauthenticated users" do
    (get :get_user_logs).should_not be_redirect
  end

  #it "sends back empty json on invalid user" do
    #get :get_user_logs
    #response.body.should == [].to_json
  #end

end
