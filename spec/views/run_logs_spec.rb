require 'spec_helper'

describe "run_logs/index" do
  it "renders date and minutes for each run log" do
    day1 = Date.today
    day2 = Date.today - 3.days

    log1 = stub_model(RunLog, {time_ran: 30, date_ran: day1})
    log2 = stub_model(RunLog, {time_ran: 60, date_ran: day2})

    assign(:run_logs, [log1, log2])
    
    render

    rendered.should have_selector("td", text: "30")
    rendered.should have_selector("td", text: "60")

    rendered.should have_selector("td", text: day1.to_s)
    rendered.should have_selector("td", text: day2.to_s)
  end

  it "renders a delete button for each run log" do
    log = stub_model(RunLog, {time_ran: 30, date_ran: Date.today})
    assign(:run_logs, [log])
    
    render

    rendered.should have_selector("form input[data-delete-log='#{log.id}']")
    rendered.should have_selector("form input[name='_method'][value='delete']")
  end
end

describe "run_logs/new" do
  it "displays the default date_ran" do
    date = Date.today - 3.days
    @run_log = RunLog.new(date_ran: date)
    render

    rendered.should have_selector("input[value='#{date.to_s}']")
  end

  it "contains the data-calendar attribute for jQueryUI calendar" do
    @run_log = RunLog.new
    render
    rendered.should have_selector("input[data-calendar='true']")
  end
end
