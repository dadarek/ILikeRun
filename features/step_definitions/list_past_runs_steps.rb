Given /I visit the run log history screen/ do
  visit run_logs_path
end

Given /I visit the enter-run-log screen/ do
  visit new_run_log_path
end

When /I click on history/ do
  click_link "History"
end

Then /I go to the history page/ do
  current_path.should == run_logs_path
end

When /I have entered some runs in the past/ do
  RunLog.create!(time_ran: 20, date_ran: Date.today - 3.days, user_id: @user.id)
  RunLog.create!(time_ran: 40, date_ran: Date.today - 2.days, user_id: @user.id)
  RunLog.create!(time_ran: 30, date_ran: Date.today - 1.days, user_id: @user.id)
end

When /Other users have also entered runs in the past/ do
  other_user = User.create!(user_name: "jonesy", password: "jones")
  RunLog.create!(time_ran: 25, date_ran: Date.today, user_id: other_user.id)
  RunLog.create!(time_ran: 46, date_ran: Date.today, user_id: other_user.id)
  RunLog.create!(time_ran: 63, date_ran: Date.today, user_id: other_user.id)
end

Then /I should see my runs$/ do
  page.body.should have_selector("td", text: /^20$/)
  page.body.should have_selector("td", text: /^30$/)
  page.body.should have_selector("td", text: /^40$/)
end

Then /I should not see other peoples runs$/ do
  page.body.should_not have_selector("td", text: /^25$/)
  page.body.should_not have_selector("td", text: /^46$/)
  page.body.should_not have_selector("td", text: /^63$/)
end

Then /I should see my runs ordered by most-recent first/ do
  page.body.should =~ /30.*?40.*?20/m
end
