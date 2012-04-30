Given /My schedule has the following days/ do |table|
  table.hashes.each do |hash|
    day = hash[:day]
    @user.schedule.send("#{day.downcase}=", true)
  end
  @user.schedule.save!
end 

When /I click on the image for "(.+)"/ do |day|
  page.find(:css, "[data-day-of-week='#{day}']" ).click
end

Then /My schedule should look like this/ do | table |
  table.hashes.each do |hash|
    day = hash[:day]
    running = hash[:running?] == "X"
    page.should have_selector("[data-day-of-week='#{day}'][data-is-running='#{running}']")
  end
end

