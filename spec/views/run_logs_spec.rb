require 'spec_helper'

describe "run_logs/index" do

  before :each do
    user = create_user
    @log1 = RunLog.create!(date_ran: Date.today - 1.day, time_ran: 30, user_id: user.id)
    @log2 = RunLog.create!(date_ran: Date.today - 3.day, time_ran: 60, user_id: user.id)

    assign(:run_logs, [@log1, @log2])
  end

  it "renders date and minutes for each run log" do
    render

    rendered.should have_selector("td", text: @log1.time_ran.to_s)
    rendered.should have_selector("td", text: @log2.time_ran.to_s)

    rendered.should have_selector("td", text: @log1.date_ran.to_s)
    rendered.should have_selector("td", text: @log2.date_ran.to_s)
  end

  it "renders a delete button for each run log" do
    render

    rendered.should have_selector("form input[data-delete-log='#{@log1.id}']")
    rendered.should have_selector("form input[data-delete-log='#{@log2.id}']")
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
