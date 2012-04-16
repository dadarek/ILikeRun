Given /I visit the run log history screen/ do
  visit '/run_logs'
end

Given /I am on the enter-run-log page/ do
  visit '/run_logs/new'
end

When /I click on history/ do
  click_link "History"
end

Then /I go to the history page/ do
  current_path.should == run_logs_path
end

When /I have entered some runs in the past/ do
  RunLog.create!( time_ran: 20 )
  RunLog.create!( time_ran: 40 )
  RunLog.create!( time_ran: 30 )
end

Then /I should see those runs ordered by most-recent first/ do
  page.body.should =~ /30.*?40.*?20/m
end
