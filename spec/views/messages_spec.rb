require 'spec_helper'

describe "layouts/_messages" do

  before :each do
    stub_views_current_user nil
  end

  def have_notice
    have_selector ".notice", text: flash[:notice]
  end

  def have_alert
    have_selector ".alert", text: flash[:alert]
  end

  def have_welcome name = nil
    have_selector ".welcome-text", text: name
  end

  it "renders notice if flash[:notice] present" do
    flash[:notice] = "el notice"
    render
    rendered.should have_notice
  end

  it "does not render notice if flash[:notice] is missing" do
    render
    rendered.should_not have_notice
  end

  it "renders alert if flash[:alert] present" do
    flash[:alert] = "Some alert"
    render
    rendered.should have_alert
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
    user = create_user
    stub_views_current_user user
    render
    rendered.should have_welcome(user.user_name)
  end

end
