Given /I am on the run log history screen/ do
  visit '/run_logs/show'
end

Given /I have entered some runs in the past/ do
  RunLogs.create!( time_ran: 20 )
  RunLogs.create!( time_ran: 30 )
  RunLogs.create!( time_ran: 40 )
end

Then /I should see the runs I entered/ do
  page.should contain("20")
  page.should contain("30")
  page.should contain("40")
end
