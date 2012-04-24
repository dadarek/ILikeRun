Given /I visit the run log history screen/ do
  visit run_logs_path
end

Given /I am on the enter-run-log page/ do
  visit new_run_log_path
end

When /I click on history/ do
  click_link "History"
end

Then /I go to the history page/ do
  current_path.should == run_logs_path
end

When /I have entered some runs in the past/ do
  RunLog.create!(time_ran: 20, user_id: @user.id)
  RunLog.create!(time_ran: 40, user_id: @user.id)
  RunLog.create!(time_ran: 30, user_id: @user.id)
end

When /Other users have also entered runs in the past/ do
  other_user = User.create!(user_name: "jonesy", password: "jones")
  RunLog.create!(time_ran: 25, user_id: other_user.id)
  RunLog.create!(time_ran: 46, user_id: other_user.id)
  RunLog.create!(time_ran: 63, user_id: other_user.id)
end

Then /I should see my runs$/ do
  page.body.should =~ /20/
  page.body.should =~ /30/
  page.body.should =~ /40/
end

Then /I should not see other peoples runs$/ do
  page.body.should_not =~ /25/
  page.body.should_not =~ /63/
  page.body.should_not =~ /46/
end

Then /I should see my runs ordered by most-recent first/ do
  page.body.should =~ /30.*?40.*?20/m
end
