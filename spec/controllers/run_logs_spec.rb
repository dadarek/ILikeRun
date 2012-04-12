require 'spec_helper'

describe RunLogsController do

  describe "#create" do
    before :each do
      post :create, time_ran: 30
    end

    it "should redirect to home page" do
      response.should redirect_to root_path
    end

    it "creates a Runlog" do
      RunLog.should have(1).items
    end

  end

end
