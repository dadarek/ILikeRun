require 'spec_helper'

describe "run_logs/index" do
  it "renders date and minutes for each run log" do
    day1 = Date.today
    day2 = Date.today - 3.days

    log1 = stub_model(RunLog, {time_ran: 30, created_at: day1})
    log2 = stub_model(RunLog, {time_ran: 60, created_at: day2})

    assign(:run_logs, [log1, log2])
    
    render

    rendered.should =~ /30/
    rendered.should =~ /60/

    rendered.should =~ Regexp.new(day1.to_s)
    rendered.should =~ Regexp.new(day2.to_s)
  end
end
