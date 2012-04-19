require 'spec_helper'

describe "layouts/_menu" do

  def have_logout 
    have_selector "a[href='#{logout_path}']"
  end

  def have_history
    have_selector "a[href='#{run_logs_path}']"
  end

  def have_schedule
    have_selector "a[href='#']"
  end

  it "renders menu links if user present" do
    session[:user_id] = 5
    render
    rendered.should have_logout
    rendered.should have_history
    rendered.should have_schedule
  end

  it "does not render menu links if user not present" do
    render
    rendered.should_not have_logout
    rendered.should_not have_history
    rendered.should_not have_schedule
  end

end
