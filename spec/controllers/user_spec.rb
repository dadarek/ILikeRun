require 'spec_helper'

describe UsersController do

  it "allows unauthenticated users" do
    (get :login).should_not be_redirect
  end

  describe "#login" do
    it "redirects to new -run-log if already logged in" do
      login(create_user)
      (get :login).should redirect_to(:new_run_log)
    end
  end

  describe "#logout" do
    it "redirects to home page" do
      (get :logout).should redirect_to(:root)
    end

    it "delegates to ApplicationController.logged_out" do
      @controller.should_receive(:logged_out)
      login(create_user)
      get :logout
    end
  end

  describe "#authenticate" do
    before :each do
      @user_name = "somebody"
      @password = "somepassword"
    end

    def make_post
      post :authenticate, user: {user_name: @user_name, password: @password } 
    end

    it "redirects to login on invalid credentials" do
      make_post.should redirect_to :users_login
    end

    it "creates alert on invalid credentials" do
      make_post
      flash.now[:alert].should_not be_nil
    end

    it "redirects to add-run-log on valid credentials" do
      create_user(@user_name, @password)
      make_post.should redirect_to(:new_run_log)
    end

    it "does not create alert on valid credentials" do
      create_user(@user_name, @password)
      make_post
      flash.now[:alert].should be_nil
    end

    it "delegates to ApplicationController.logged_in" do
      user = create_user(@user_name, @password)
      @controller.should_receive(:logged_in).with(user)
      make_post
    end

    pending "expires after 30 minutes"
  end
end
