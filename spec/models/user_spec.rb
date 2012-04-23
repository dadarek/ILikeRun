require 'spec_helper'

describe User do

  it "rejects empty username" do
    expect{ create_user("", "password") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "rejects empty password" do
    expect{ create_user("use_name", "") }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "creates salt on save" do
    user = create_user
    user.salt.should_not be_nil
  end

  it "does not allow updates" do
    user = create_user
    lambda{ user.save }.should throw_symbol( :update_disallowed )
  end

  it "requires unique usernames" do
    create_user
    expect{ create_user }.to raise_error(ActiveRecord::RecordInvalid)
  end

  it "encrypts password before saving" do
    user = create_user("san", "francisco")
    encrypted = BCrypt::Engine.hash_secret "francisco", user.salt
    user.password.should == encrypted
  end

  it "returns a valid user on succesful authentication" do
    user = create_user("rudolph", "santa")
    User.authenticate("rudolph", "santa").should == user
  end
  
  it "ignores case on user_name" do
    user = create_user("name", "pw")
    User.authenticate( "NAME", "pw" ).should == user
    User.authenticate( "name", "pw" ).should == user
  end

  it "returns nil on bad password" do
    create_user("user", "pw")
    User.authenticate( "user", "password" ).should be_nil
  end

  it "returns nil on bad username" do
    User.authenticate( "john", "deere" ).should be_nil
  end

end
