require 'spec_helper'

describe "layouts/application" do

  def logout_selector
    "a[href='#{logout_path}']"
  end

  def welcome_selector
    ".welcome-text"
  end

  it "does not render welcome text if user not present" do
    render
    rendered.should_not have_selector welcome_selector
  end
  
  it "renders welcome text if user present" do
    session[:user_id] = 5
    render
    rendered.should have_selector welcome_selector
  end

  it "renders logout link if user present" do
    session[:user_id] = 5
    render
    rendered.should have_selector logout_selector
  end

  it "does not render logout link if user not present" do
    render
    rendered.should_not have_selector logout_selector
  end

end
