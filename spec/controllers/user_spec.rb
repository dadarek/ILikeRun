require 'spec_helper'

describe UsersController do

  describe "#login" do
    it "initializes an empty User" do
      get :login
      assigns(:user).should be_an_instance_of(User)
    end
  end

  describe "#authenticate" do
    it "redirects to login on invalid credentials" do
      (post :authenticate, user: {user_name: "b", password: "c"}).should redirect_to :users_login
    end

    it "rejects invalid credentials" do
      post :authenticate, user: {user_name: "b", password: "c"}
      flash.now[:alert].should_not be_nil
    end
  end
end
