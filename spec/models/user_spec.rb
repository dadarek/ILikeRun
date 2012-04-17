require 'spec_helper'

describe User do

  def params
    { user_name: "elUser", password: "password", salt: "salt" }
  end

  def params_without field
    result = params
    result.delete field
    result
  end

  it "rejects empty username" do
    user = User.create( params_without :user_name )
    user.should_not be_valid
  end

  it "rejects empty password" do
    user = User.create( params_without :password )
    user.should_not be_valid
  end

  it "rejects empty salt" do
    user = User.create( params_without :salt )
    user.should_not be_valid
  end

  it "requires unique usernames" do
    user1 = User.create!( params )
    user2 = User.create( params )
    user1.should be_valid
    user2.should_not be_valid
  end

end
