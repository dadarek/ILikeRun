require 'spec_helper'

module ApplicationControllerTests

  class TestController < ApplicationController
    def index
      render nothing: true
    end
  end

  describe TestController do

    before :each do
      @controller = TestController.new
      @controller.stub(:session).and_return(session)

      @user = User.create!( user_name: "bob", password: "barker" )
    end

    it "redirects to login if not authenticated" do
      (get :index).should redirect_to :users_login
    end

    it "does not redirect to login if logged in" do
      @controller.login @user
      (get :index).should_not redirect_to :users_login
    end

    it "logs in user" do
      @controller.login @user
      @controller.current_user.should == @user
    end

    it "returns no user if user does not login" do
      @controller.current_user.should be_nil
    end

  end

end
