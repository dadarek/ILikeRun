require 'spec_helper'

module ApplicationControllerTests

  class TestController < ApplicationController
    def index
      render nothing: true
    end
  end

  describe TestController do

    before :each do
      @user = create_user
    end

    it "redirects to login if not authenticated" do
      (get :index).should redirect_to :users_login
    end

    it "does not redirect to login if logged in" do
      @controller.stub(:current_user).and_return(@user)
      (get :index).should_not be_redirect
    end

    it "logs in user" do
      @controller.logged_in @user
      @controller.current_user.should == @user
    end

    it "returns no user if user does not login" do
      @controller.current_user.should be_nil
    end

    it "logs user out" do
      @controller.logged_in @user
      @controller.logged_out
      @controller.current_user.should be_nil
    end

  end

end
