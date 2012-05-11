require 'spec_helper'

describe ChartsController do

  before :each do
    @user = create_user
    login @user
  end

  context 'charting server running' do
    it "ignores logs older than 2 weeks" do
      log1 = create_run_log(Date.today)
      log2 = create_run_log(Date.today - 5.days)
      log3 = create_run_log(Date.today - 1.week)

      thirteen_days_ago = create_run_log(Date.today - 13.days)
      two_weeks_ago = create_run_log(Date.today - 2.weeks)

      logs_url = create_logs_url [log1, log2, log3, thirteen_days_ago]

      HTTParty.should_receive(:get).with(logs_url)
      get :index
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
  end

  context 'charting server down' do

    before :each do
      HTTParty.stub(:get).and_throw(:exception)
    end

    it 'redirects if error connecting to charting server' do
      (get :index).should redirect_to(action: "unavailable")
    end

    it 'sets an error in flash' do
      get :index
      flash[:alert].should_not be_nil
    end
  end

  it 'has a action unavailable' do
    (get :unavailable).should render_template('unavailable')
  end

end

