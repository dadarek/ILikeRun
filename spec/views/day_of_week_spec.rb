require 'spec_helper'

describe "schedules/_day_of_week" do

  before :each do
    @schedule = Schedule.new
    assign(:schedule, @schedule)
    view.stub(:day_of_week).and_return("Tuesday")
  end

  it "displays post form on inactive day" do
    render
    rendered.should_not have_selector "input[name='_method'][value='delete']"
  end

  it "renders a hidden with given day of week" do
    render
    rendered.should have_selector "input[value='Tuesday']"
  end

  it "renders a image-submit tag" do
    render
    rendered.should have_selector "input[src$='not-running.jpg']"
  end

  it "renders a delete form on days scheduled to run" do
    @schedule.tuesday = true
    render
    rendered.should have_selector "input[name='_method'][value='delete']"
  end

  it "renders a 'running' image-submit tag" do
    @schedule.tuesday = true
    render
    rendered.should have_selector "input[src$='yes-running.jpg']"
  end

end

