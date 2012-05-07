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
    logs_json = logs.to_json( only: [:date_ran, :time_ran] )
    logs_encoded = URI.encode logs_json

    charting_server = Rails.configuration.charting_server

    logs_url = charting_server + "/?" + logs_encoded

    get :index
    assigns(:logs_data_url).should == logs_url
  end

  it 'returns oldest logs first' do
    yesterday = create_log Date.today - 1.days
    today = create_log Date.today
    two_days_ago = create_log Date.today - 2.days

    logs = [two_days_ago, yesterday, today]

    logs_json = logs.to_json( only: [:date_ran, :time_ran] )
    logs_encoded = URI.encode logs_json

    charting_server = Rails.configuration.charting_server

    logs_url = charting_server + "/?" + logs_encoded
    get :index
    assigns(:logs_data_url).should == logs_url
  end

  it 'sets @logs_data_url to encoded logs' do
    log1 = create_log Date.today
    log2 = create_log Date.today - 5.days
    log3 = create_log Date.today - 1.week

    thirteen_days_ago = create_log Date.today - 13.days
    two_weeks_ago = create_log Date.today - 2.weeks

    logs = [thirteen_days_ago, log3, log2, log1]
    logs_json = logs.to_json( only: [:date_ran, :time_ran] )
    logs_encoded = URI.encode logs_json

    charting_server = Rails.configuration.charting_server

    logs_url = charting_server + "/?" + logs_encoded

    get :index
    assigns(:logs_data_url).should == logs_url
  end

  def create_log date_ran
    RunLog.create!(date_ran: date_ran, time_ran: 1, user_id: @user.id)
  end

end

