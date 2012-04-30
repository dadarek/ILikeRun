Given /a user "(.*?)" with password "(.*?)"/ do |user_name, password|
  @user = User.create!(user_name: user_name, password: password)
end

Given /I am logged in/ do
  step %|a user "zelda" with password "sword"|
  step %|I visit the login screen|
  step %|I fill in "zelda" for "username"|
  step %|I fill in "sword" for "password"|
  step %|I click the "Login" button|
end

When /I fill in "(.*?)" for "(.*?)"/ do |value, field|
  field = "user_name" if field == "username"
  fill_in "user[#{field}]", with: value
end

Then /I should be logged in/ do
  page.should have_selector ".welcome-text"
end

Then /I should not be logged in/ do
  page.should_not have_selector ".welcome-text"
end

Then /I should be on the "(.*?)" screen/ do |screen|
  expected_url = new_run_log_url
  expected_url = root_url if screen == "home page"

  current_url.should == expected_url 
end
