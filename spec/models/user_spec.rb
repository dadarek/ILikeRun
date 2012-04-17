require 'spec_helper'

describe User do

  it "rejects empty username" do
    user = User.create( password: "password", salt: "salt" )
    user.should_not be_valid
  end

  it "rejects empty password" do
    user = User.create( user_name: "A", salt: "salt" )
    user.should_not be_valid
  end

  it "rejects empty salt" do
    user = User.create( user_name: "A", password: "P" )
    user.should_not be_valid
  end

  it "requires unique usernames" do
    user1 = User.create!( user_name: "A", password: "password", salt: "salt" )
    user2 = User.create( user_name: "A", password: "password", salt: "salt" )
    user1.should be_valid
    user2.should_not be_valid
  end

end
