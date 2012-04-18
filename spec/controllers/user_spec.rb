require 'spec_helper'

describe UsersController do

  it "does not have the ensure_is_logged_in before filter" do
    all_filters = UsersController._process_action_callbacks
    before_filters = all_filters.select{|f| f.kind == :before }
    filter_names =before_filters.map(&:filter) 

    filter_names.should_not include(:ensure_is_logged_in)
  end

  describe "#login" do
    it "initializes an empty User" do
      get :login
      assigns(:user).should be_an_instance_of(User)
    end

    it "redirects to new -run-log if already logged in" do
      session[:user_id] = 15
      (get :login).should redirect_to(:new_run_log)
    end

    pending "redirect to home from run logs if not logged in"
  end

  describe "#authenticate" do
    def params
      {user_name: "b", password: "c"}
    end
    def make_post
      post :authenticate, user: params 
    end

    it "redirects to login on invalid credentials" do
      make_post.should redirect_to :users_login
    end

    it "creates alert on credentials" do
      make_post
      flash.now[:alert].should_not be_nil
    end

    it "redirects to add-run-log on valid credentials" do
      User.create! params 
      make_post.should redirect_to(:new_run_log)
    end

    it "does not create alert on valid credentials" do
      User.create! params 
      make_post
      flash.now[:alert].should be_nil
    end

    it "sets session variable after valid login" do
      user = User.create! params 
      make_post
      session[:user_id].should == user.id
    end

    pending "expires after 30 minutes"

    pending "logout"
  end
end
