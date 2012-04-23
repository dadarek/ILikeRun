require 'spec_helper'

describe "schedules/index" do

  it "contains all days of week" do
    assign :schedule, Schedule.new
    render
    Date::DAYNAMES.each{ |day|
      rendered.should =~ Regexp.new(day)
    }
  end

  it "displays yes and no images" do
    schedule = Schedule.new
    schedule.monday = true
    schedule.saturday  = true
    schedule.sunday = true

    assign :schedule, schedule
    render
    rendered.should have_selector "img[src$='not-running.jpg']", count: 4
    rendered.should have_selector "img[src$='yes-running.jpg']", count: 3
  end

end
