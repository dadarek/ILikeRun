require 'spec_helper'

describe "schedules/index" do

  it "contains all days of week" do
    render
    Date::DAYNAMES.each{ |day|
      rendered.should =~ Regexp.new(day)
    }
  end

end
