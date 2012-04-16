Given /I visit the run log history screen/ do
  visit '/run_logs'
end

Given /I have entered some runs in the past/ do
  RunLog.create!( time_ran: 20 )
  RunLog.create!( time_ran: 30 )
  RunLog.create!( time_ran: 40 )
end

Then /I should see the runs I entered/ do
  page.should have_content("20")
  page.should have_content("30")
  page.should have_content("40")
end
