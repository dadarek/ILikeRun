Given /I visit the run log history screen/ do
  visit '/run_logs'
end

Given /I have entered some runs in the past/ do
  RunLog.create!( time_ran: 20 )
  RunLog.create!( time_ran: 40 )
  RunLog.create!( time_ran: 30 )
end

Then /I should see those runs ordered by most-recent first/ do
  page.body.should =~ /30.*?40.*?20/m
end
