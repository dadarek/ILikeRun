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
  page.find(:css, image_for(day) ).click
end

Then /My schedule should look like this/ do | table |
  table.hashes.each do |hash|
    day_css = image_for(hash[:day])
    running = hash[:running?] == "X"

    if running 
      page.should have_selector day_css
    else
      page.should_not have_selector day_css
    end
  end
end

def image_for day
  "input[value='#{day}'] ~ input[src$='yes-running.jpg']"
end
