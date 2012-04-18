require 'spec_helper'

describe UsersController do

  describe "#login" do
    it "initializes an empty User" do
      get :login
      assigns(:user).should be_an_instance_of(User)
    end

    pending "it should redirect to run logs if already logged in"
  end

  describe "#authenticate" do
    it "redirects to login on invalid credentials" do
      (post :authenticate, user: {user_name: "b", password: "c"}).should redirect_to :users_login
    end

    it "posts message on credentials" do
      post :authenticate, user: {user_name: "b", password: "c"}
      flash.now[:alert].should_not be_nil
    end

    it "redirects to home page on valid credentials" do
      params = {user_name: "b", password: "c"}
      User.create! params 
      (post :authenticate, user: params).should redirect_to(:root)
    end

  end
end
