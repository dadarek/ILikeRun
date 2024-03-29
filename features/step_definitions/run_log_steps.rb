When /I enter (\-?\d+) minutes for my time ran/ do |minutes|
  fill_in "run_log[time_ran]", with: minutes
end

When /I enter "(.+)" for my date ran/ do |date|
  fill_in "run_log[date_ran]", with: date
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

