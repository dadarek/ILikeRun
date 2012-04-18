require 'spec_helper'

describe User do

  def create_user 
    User.create(user_name: "user", password: "password")
  end

  def params 
    {user_name: "user", password: "password"}
  end

  it "rejects empty username" do
    user = User.create( password: "passw" )
    user.should_not be_valid
  end

  it "rejects empty password" do
    user = User.create( user_name: "UserName" )
    user.should_not be_valid
  end

  it "creates salt on save" do
    user = create_user
    user.salt.should_not be_nil
  end

  it "does not allow updates" do
    pending "Make sure do not override salt"
  end

  it "requires unique usernames" do
    user1 = create_user
    user2 = create_user
    user1.should be_valid
    user2.should_not be_valid
  end

  it "encrypts password before saving" do
    user = create_user
    encrypted = BCrypt::Engine.hash_secret params[:password], user.salt
    user.password.should == encrypted
  end

  it "returns a valid user on succesful authentication" do
    user = create_user
    User.authenticate( params[:user_name], params[:password] ).should == user
  end

  it "returns nil on bad password" do
    user = create_user
    User.authenticate( params[:user_name], "bad-password" ).should be_nil
  end

  it "returns nil on bad username" do
    User.authenticate( "john", "deere" ).should be_nil
  end

end
