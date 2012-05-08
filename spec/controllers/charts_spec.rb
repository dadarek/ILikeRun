require 'spec_helper'

describe ChartsController do

  before :each do
    HTTParty.stub(:get)

    @user = create_user
    login @user
  end

  it "ignores logs older than 2 weeks" do
    log1 = create_log Date.today
    log2 = create_log Date.today - 5.days
    log3 = create_log Date.today - 1.week

    thirteen_days_ago = create_log Date.today - 13.days
    two_weeks_ago = create_log Date.today - 2.weeks

    logs_url = create_logs_url [thirteen_days_ago, log3, log2, log1]

    get :index
    assigns(:logs_data_url).should == logs_url
  end

  it 'returns oldest logs first' do
    yesterday = create_log Date.today - 1.days
    today = create_log Date.today
    two_days_ago = create_log Date.today - 2.days

    logs_url = create_logs_url [two_days_ago, yesterday, today]

    get :index
    assigns(:logs_data_url).should == logs_url
  end

  it 'sets @logs_data_url to encoded logs' do
    log1 = create_log Date.today
    log2 = create_log Date.today - 5.days
    log3 = create_log Date.today - 1.week

    thirteen_days_ago = create_log Date.today - 13.days

    logs_url = create_logs_url [thirteen_days_ago, log3, log2, log1]

    get :index
    assigns(:logs_data_url).should == logs_url
  end

  it 'redirects if error connecting to charting server' do
    HTTParty.stub(:get).and_throw(:exception)
    (get :index).should redirect_to(action: "unavailable")
  end

  it 'assigns chart_data_points to return value of url' do
    HTTParty.stub(:get).and_return('meow meow meow')
    get :index
    assigns(:chart_data_points).should == 'meow meow meow'
  end

  def create_logs_url logs
    logs_json = logs.to_json( only: [:date_ran, :time_ran] )
    logs_encoded = URI.encode logs_json

    charting_server = Rails.configuration.charting_server

    charting_server + "/?" + logs_encoded
  end

  def create_log date_ran
    RunLog.create!(date_ran: date_ran, time_ran: 1, user_id: @user.id)
  end

end

