require 'spec_helper'

describe "layouts/_messages" do

  def have_notice
    have_selector ".notice" 
  end

  def have_alert
    have_selector ".alert" 
  end

  def have_welcome
    have_selector ".welcome-text"
  end

  it "compiles" do
    flash[:notice] = "el notice"
    render
    rendered.should =~ /el notice/
  end

  it "renders notice if flash[:notice] present" do
    flash[:notice] = "el notice"
    render
    rendered.should have_notice
    rendered.should =~ /el notice/
  end

  it "does not render notice if flash[:notice] is missing" do
    render
    rendered.should_not have_notice
  end

  it "renders alert if flash[:alert] present" do
    flash[:alert] = "Some alert"
    render
    rendered.should have_alert
    rendered.should =~ /Some alert/
  end

  it "renders alert if flash[:alert] is missing" do
    render
    rendered.should_not have_alert
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

end
