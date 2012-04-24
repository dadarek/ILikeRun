Given /My schedule has the following days/ do |table|
  table.hashes.each do |hash|
    day = hash[:day]
    @user.schedule.send("#{day.downcase}=", true)
  end
  @user.schedule.save!
end 

Given /I am on the schedule page/ do
  visit schedules_path
end

When /I click on the image for "(.+)"/ do |day|

end

Then /I should see the following days/ do | table |
  table.hashes.each do |hash|
    day = hash[:day]
    page.should have_selector "input[value='#{day}'] ~ input[src$='yes-running.jpg']"
  end
end

