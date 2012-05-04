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

    logs = [thirteen_days_ago, log3, log2, log1]

    get :index
    assigns(:run_logs).should == logs
  end

  it 'returns oldest logs first' do
    yesterday = create_log Date.today - 1.days
    today = create_log Date.today
    two_days_ago = create_log Date.today - 2.days

    logs = [two_days_ago, yesterday, today]

    get :index
    assigns(:run_logs).should == logs
  end

  def create_log date_ran
    RunLog.create!(date_ran: date_ran, time_ran: 1, user_id: @user.id)
  end

end

