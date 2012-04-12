require 'spec_helper'

describe "index page" do
  
  before :each do
    visit "/run_logs"
  end

  it "displays success after a log post" do
    fill_in "time_ran", with: 30
    click_button "Save"

    page.should have_notice
  end 

  it "does not display success before log post" do
    page.should_not have_notice
  end

  it "displays failure after a bad post" do
    click_button "Save"
    page.should have_alert 
  end

  it "does not display failure before post" do
    page.should_not have_alert
  end

  def have_notice
    have_selector ".notice"
  end

  def have_alert
    have_selector ".alert"
  end

end
