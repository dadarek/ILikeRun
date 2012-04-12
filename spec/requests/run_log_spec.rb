require 'spec_helper'

describe "index page" do

  it "displays success after a log post" do
    visit "/"
    fill_in "time_ran", with: 30
    click_button "Save"

    page.should have_selector(".message", text: "Success")
  end 

end
