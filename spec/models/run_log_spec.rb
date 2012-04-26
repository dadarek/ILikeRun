require 'spec_helper'

describe RunLog do

  before :each do
    @run_log = RunLog.new
    @run_log.date_ran = Date.today
    @run_log.time_ran = 30
  end

  it "Validates with a good date and time_ran" do
    @run_log.should be_valid
  end

  it "Rejects nil run times" do
    @run_log.time_ran = nil
    @run_log.should_not be_valid
  end

  it "Rejects 0 run times" do
    @run_log.time_ran = 0
    @run_log.should_not be_valid
  end

  it "Rejects negative run times" do
    @run_log.time_ran = -30
    @run_log.should_not be_valid
  end

  it "Rejects nil dates" do
    @run_log.date_ran = nil
    @run_log.should_not be_valid
  end

  it "Rejects invalid dates" do
    @run_log.date_ran = 5
    @run_log.should_not be_valid
  end

  it "Rejects future dates" do
    @run_log.date_ran = Date.today + 1.day
    @run_log.should_not be_valid
  end

end
