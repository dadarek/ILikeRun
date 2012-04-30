Given /I visit the run log history screen/ do
  visit run_logs_path
end

Given /I visit the enter-run-log screen/ do
  visit new_run_log_path
end

When /I click on history/ do
  click_link "History"
end

Then /I should be on the history page/ do
  current_path.should == run_logs_path
end

Then /^I should not see the following run logs$/ do |table|
  table.hashes.each do |hash|
    time_ran = Regexp.new hash[:time_ran]
    date_ran = Regexp.new hash[:date_ran]
    page.body.should_not have_selector("td", text: time_ran)
    page.body.should_not have_selector("td", text: date_ran)
  end
end 

Then /^I should see the following run logs$/ do |table|
  table.hashes.each do |hash|
    time_ran = Regexp.new hash[:time_ran]
    date_ran = Regexp.new hash[:date_ran]
    page.body.should have_selector("td", text: time_ran)
    page.body.should have_selector("td", text: date_ran)
  end
end 

Then /^I should see the following run logs in this order$/ do |table|
  dates = table.hashes.collect{ |hash| hash[:date_ran] }
  times = table.hashes.collect{ |hash| hash[:time_ran] }
  dates_r = Regexp.new(dates.join(".*?"), Regexp::MULTILINE)
  times_r = Regexp.new(times.join(".*?"), Regexp::MULTILINE)

  page.body.should =~ dates_r
  page.body.should =~ times_r
end 

