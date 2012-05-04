require 'spec_helper'

describe ChartsController do

  before :each do
    @user = create_user
    login @user
  end

  it "sets logs to an array of last 2 weeks" do
    log1 = create_log(Date.today, 10)
    logs = [log1]
    get :index
    assigns(:run_logs).should == logs
  end

  def create_log(date_ran, time_ran)
    RunLog.create!(date_ran: date_ran, time_ran: time_ran, user_id: @user.id)
  end

end

