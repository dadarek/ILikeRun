require 'spec_helper'

describe RunLog do

  before :each do
    @run_log = RunLog.new
    @run_log.created_at = Date.today
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
    @run_log.created_at = nil
    @run_log.should_not be_valid
  end

end
