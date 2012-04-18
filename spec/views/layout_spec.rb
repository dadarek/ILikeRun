require 'spec_helper'

describe "layouts/application" do

  def have_logout 
    have_selector "a[href='#{logout_path}']"
  end

  def have_welcome
    have_selector ".welcome-text"
  end

  def have_notice
    have_selector ".notice" 
  end


  it "does not render welcome text if user not present" do
    render
    rendered.should_not have_welcome
  end
  
  it "renders welcome text if user present" do
    session[:user_id] = 5
    render
    rendered.should have_welcome
  end

  it "renders logout link if user present" do
    session[:user_id] = 5
    render
    rendered.should have_logout
  end

  it "does not render logout link if user not present" do
    render
    rendered.should_not have_logout
  end

  it "renders notice if flash[:notice] present" do
    flash[:notice] = "Some notice"
    render
    rendered.should have_notice
  end

  it "does not render notice if flash[:notice] is missing" do
    render
    rendered.should_not have_notice
  end

  pending "How do you print out 'Welcome, username?"

end
