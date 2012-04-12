require 'spec_helper'

describe RunLogsController do

  describe "#create" do
    it "should redirect to home page" do
      post :create, time_ran: 30
      response.should redirect_to root_path
    end

    it "creates a Runlog" do
      post :create, time_ran: 30
      RunLog.should have(1).items
    end

  end

end
