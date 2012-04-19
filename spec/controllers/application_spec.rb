require 'spec_helper'

describe ApplicationController do

  before :each do
    @controller = ApplicationController.new
    @controller.stub(:session).and_return(session)
  end

  it "has an authenticate before filter" do
    all_filters = ApplicationController._process_action_callbacks
    before_filters = all_filters.select{|f| f.kind == :before }
    filter_names =before_filters.map(&:filter) 

    filter_names.should include(:ensure_is_logged_in)
  end

  it "redirects to login if not authenticated" do
    pending "The below does not work..."
    #@controller.ensure_is_logged_in.should redirect_to(:users_login)
  end

  it "returns no user if session[:user_id] is nil" do
    @controller.current_user.should be_nil
  end

  it "returns user associated with session[:user_id]" do
    user = User.create!( user_name: "bob", password: "barker" )
    session[:user_id] = user.id

    @controller.current_user.should == user
  end

end
