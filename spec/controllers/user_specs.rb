require 'spec_helper'

describe UsersController do

  describe "#login" do
    it "initializes an empty User" do
      get :login
      assigns(:user).should be_an_instance_of(User)
    end
  end

  describe "#authenticate" do
    it "rejects invalid credentials" do
      pending "Finish this after model."
    end
  end
end
