require 'spec_helper'

describe ChartsController do

  before :each do
    @user = create_user
    login @user
  end

  it "sets logs to an array of last 2 weeks" do
    log1 = create_log Date.today
    log2 = create_log Date.today - 5.days
    log3 = create_log Date.today - 1.week

    thirteen_days_ago = create_log Date.today - 13.days
    two_weeks_ago = create_log Date.today - 2.weeks

    logs = [log1, log2, log3, thirteen_days_ago]

    get :index
    assigns(:run_logs).should == logs
  end

  it 'returns logs ordered by date' do
    log2 = create_log Date.today - 5.days
    log3 = create_log Date.today - 1.week
    log1 = create_log Date.today

    thirteen_days_ago = create_log Date.today - 13.days
    two_weeks_ago = create_log Date.today - 2.weeks

    logs = [log1, log2, log3, thirteen_days_ago]

    get :index
    assigns(:run_logs).should == logs
  end

  def create_log date_ran
    RunLog.create!(date_ran: date_ran, time_ran: 1, user_id: @user.id)
  end

end

