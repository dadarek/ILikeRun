require 'spec_helper'

describe ChartsController do

  before :each do
    @user = create_user
    login @user
  end

  context 'index' do
    it "ignores logs older than 2 weeks" do
      log1 = create_log Date.today
      log2 = create_log Date.today - 5.days
      log3 = create_log Date.today - 1.week

      thirteen_days_ago = create_log Date.today - 13.days
      two_weeks_ago = create_log Date.today - 2.weeks

      logs_url = create_logs_url [log1, log2, log3, thirteen_days_ago]

      HTTParty.should_receive(:get).with(logs_url)
      get :index
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

  context 'unavailable' do
    it 'sets an error in flash' do
      get :unavailable
      flash[:alert].should_not be_nil
    end
  end

end

