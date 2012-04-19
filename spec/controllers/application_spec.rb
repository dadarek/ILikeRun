require 'spec_helper'

describe ApplicationController do

  before :each do
    @controller = ApplicationController.new
    @controller.stub(:session).and_return(session)

    @user = User.create!( user_name: "bob", password: "barker" )
  end

  it "has an authenticate before filter" do
    all_filters = ApplicationController._process_action_callbacks
    before_filters = all_filters.select{|f| f.kind == :before }
    filter_names =before_filters.map(&:filter) 

    filter_names.should include(:ensure_is_logged_in)
  end

  it "redirects to login if not authenticated" do
    get :ensure_is_logged_in
    response.should redirect_to :users_login
  end

  it "logs in user" do
    @controller.login @user
    @controller.current_user.should == @user
  end

  it "does not redirect to login if logged in" do
    @controller.login @user
    @controller.ensure_is_logged_in.should be_nil
  end

  it "returns no user if user does not login" do
    @controller.current_user.should be_nil
  end

end
