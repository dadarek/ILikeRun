require 'spec_helper'

describe "index page" do

  it "displays success after a log post" do
    visit "/run_logs"
    fill_in "time_ran", with: 30
    click_button "Save"

    page.should have_selector(".notice", text: "Success")
  end 

  it "does not display success before log post" do
    visit "/run_logs"
    page.should_not have_selector(".notice", text: "Success")
  end

end
