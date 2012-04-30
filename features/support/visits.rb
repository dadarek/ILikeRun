Given /I visit the run log history screen/ do
  visit run_logs_path
end

Given /I visit the enter-run-log screen/ do
  visit new_run_log_path
end

Given /I visit the Run log screen/ do
  visit new_run_log_path
end

Given /I visit the schedule screen/ do
  visit schedules_path
end

When /I visit the login screen/ do
  visit users_login_path
end

