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

    it "redirects to home page on valid credentials" do
      User.create! params 
      make_post.should redirect_to(:root)
    end

  end
end
