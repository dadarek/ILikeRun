require 'spec_helper'

describe "schedules/_day_of_week" do

  it "displays post form on inactive day" do
    assign(:day_of_week, "Monday")
    render
    rendered.should have_selector "form[method='post']"
  end

  it "renders a hidden with given day of week" do
    assign(:day_of_week, "Tuesday")
    render
    rendered.should have_selector "input[value='Tuesday']"
  end

  it "renders renders a image-submit tag" do
    assign(:day_of_week, "Friday")
    render
    rendered.should have_selector "submit[src='not-running.jpg']"
  end

end

