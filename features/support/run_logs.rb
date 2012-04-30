Given /^I have the following run logs$/ do |table|
  table.hashes.each do |hash|
    hash[:user_id] = @user.id
    RunLog.create! hash
  end
end

Given /^Another user has the following run logs$/ do |table|
  fred = User.create!(user_name: 'Fred', password: 'x')
  table.hashes.each do |hash|
    hash[:user_id] = fred.id
    RunLog.create! hash
  end
end

Then /^I should have the following run logs$/ do |table|
  table.hashes.each do |hash|
    get_users_log(hash).should_not be_nil
  end
end 

Then /^I should not have the following run logs$/ do |table|
  table.hashes.each do |hash|
    get_users_log(hash).should be_nil
  end
end

def get_users_log hash
  date_ran = hash[:date_ran]
  time_ran = hash[:time_ran]
  logs = @user.run_logs.where('date_ran = ? and time_ran = ?', date_ran, time_ran)
  logs.first
end
