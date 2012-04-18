Given /a user "(.*?)" with password "(.*?)"/ do |user_name, password|
  @user = User.create!(user_name: user_name, password: password)
end

When /I visit the login screen/ do
  visit users_login_path
end

When /I fill in "(.*?)" for "(.*?)"/ do |value, field|
  field = "user_name" if field == "username"
  fill_in "user[#{field}]", with: value
end

When /I click the "(.*?)" button/ do |name|
  click_button name
end

Then /I should be logged in/ do
  page.should have_selector ".welcome-text"
end

Then /I should not be logged in/ do
  page.should_not have_selector ".welcome-text"
end

Then /I should be on the "(.*?)" screen/ do |screen|
  current_url.should == new_run_log_url 
end
