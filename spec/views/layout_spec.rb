require 'spec_helper'

describe "layouts/application" do

  it "does not render welcome text if user not present" do
    render
    rendered.should_not have_selector ".welcome-text"
  end
  
  it "renders welcome text if user present" do
    session[:user_id] = 5
    render
    rendered.should have_selector ".welcome-text"
  end

  it "renders logout link if user present" do
    session[:user_id] = 5
    render
    selector = "a[href='#{logout_path}']"
    rendered.should have_selector(selector)
  end

  it "does not render logout link if user not present" do
    render
    selector = "a[href='#{logout_path}']"
    rendered.should_not have_selector(selector)
  end

end
