Given /I am on the Run log page/ do
  visit "/run_logs"
end

When /I enter (\-?\d+) minutes for my time ran/ do |minutes|
  fill_in "time_ran", with: minutes
end

When /I click the save button/ do
  click_button "Save"
end

Then /I should see a success message/ do
  page.should have_selector ".notice"
end

Then /I should not see a success message/ do
  page.should_not have_selector ".notice"
end

Then /I should not see an error message/ do
  page.should_not have_selector ".alert"
end

Then /I should see an error message/ do
  page.should have_selector ".alert"
end

