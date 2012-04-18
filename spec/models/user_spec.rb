require 'spec_helper'

describe User do

  def params
    salt = BCrypt::Engine.generate_salt
    { user_name: "elUser", password: "password", salt: salt }
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
    user1 = User.create!(params)
    user2 = User.create(params)
    user1.should be_valid
    user2.should_not be_valid
  end

  it "encrypts password before saving" do
    user = User.create(params)
    encrypted = BCrypt::Engine.hash_secret user.password, user.salt
    user.save!

    user.password.should == encrypted
  end

  it "returns a valid user on succesful authentication" do
    user = User.create!(params)
    User.authenticate( params[:user_name], params[:password] ).should == user
  end

  it "returns nil on bad password" do
    user = User.create!(params)
    User.authenticate( params[:user_name], "bad-password" ).should be_nil
  end

  it "returns nil on bad username" do
    User.authenticate( "john", "deere" ).should be_nil
  end

end
