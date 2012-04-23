require 'spec_helper'

describe SchedulesController do

  describe "#index" do

    def create_schedule user
      Schedule.create!( user_id: user.id )
    end

    it "returns users schedule" do
      user = create_user
      create_schedule user

      login user
      get :index
      assigns(:schedule).should == user.schedule
    end

    it "does not return others schedule" do
      u1 = create_user("a", "p")
      u2 = create_user("b", "q")

      create_schedule u1
      create_schedule u2

      login u2
      get :index
      assigns(:schedule).should == u2.schedule
    end
  end

end
