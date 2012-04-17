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

end
