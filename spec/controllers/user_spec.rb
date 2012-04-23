require 'spec_helper'

describe UsersController do

  it "allows unauthenticated users" do
    (get :login).should_not be_redirect
  end

  describe "#login" do
    it "redirects to new -run-log if already logged in" do
      create_user
      login
      (get :login).should redirect_to(:new_run_log)
    end

    pending "redirect to home from run logs if not logged in"
  end

  describe "#logout" do
    it "redirects to home page" do
      (get :logout).should redirect_to(:root)
    end

    it "delegates to ApplicationController.logged_out" do
      @controller.should_receive(:logged_out)
      create_user
      login
      get :logout
    end
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

    it "delegates to ApplicationController.logged_in" do
      user = User.create! params 
      @controller.should_receive(:logged_in).with(user)
      make_post
    end

    pending "expires after 30 minutes"
  end
end
