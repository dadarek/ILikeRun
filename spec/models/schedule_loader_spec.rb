require 'spec_helper'

describe ScheduleLoader do

  it "creates a schedule for users without one" do
    user = create_user
    user.schedule = nil
    ScheduleLoader.load user
    user.reload
    user.schedule.should_not be_nil
  end

  it "does not create a schedule for users with one" do
    user = create_user
    ScheduleLoader.load user
    Schedule.where("user_id == #{user.id}").count.should == 1
  end

end
