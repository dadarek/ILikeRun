Then /I should be on the history page/ do
  current_path.should == run_logs_path
end

Then /^I should not see the following run logs$/ do |table|
  table.hashes.each do |hash|
    page.body.should_not have_run_log_date hash
    page.body.should_not have_run_log_time hash
  end
end 

Then /^I should see the following run logs$/ do |table|
  table.hashes.each do |hash|
    page.body.should have_run_log_date hash
    page.body.should have_run_log_time hash
  end
end 

def have_run_log_time hash
  time_ran = Regexp.new hash[:time_ran]
  have_selector("td", text: time_ran)
end

def have_run_log_date hash
  date_ran = Regexp.new hash[:date_ran]
  have_selector("td", text: date_ran)
end
