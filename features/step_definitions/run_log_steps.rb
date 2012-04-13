Given /I am on the Run log page/ do
  visit "/run_logs"
end

When /I fill in 20 into the time ran box/ do
  fill_in "time_ran", with: 20
end

When /I fill in -20 into the time ran box/ do
  fill_in "time_ran", with: -20
end

When /I click the save button/ do
  click_button "Save"
end

Then /I see a success message/ do
  page.should have_selector ".notice"
end

Then /I do not see a success message/ do
  page.should_not have_selector ".notice"
end

Then /I do not see an error message/ do
  page.should_not have_selector ".alert"
end

Then /I see an error message/ do
  page.should have_selector ".alert"
end

