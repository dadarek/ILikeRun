require 'spec_helper'

describe RunLog do

  it "Rejects nil run times" do
    run_log = RunLog.new
    run_log.should_not be_valid
  end

  it "Rejects 0 run times" do
    run_log = RunLog.new
    run_log.time_ran = 0
    run_log.should_not be_valid
  end

  it "Rejects negative run times" do
    run_log = RunLog.new
    run_log.time_ran = -30
    run_log.should_not be_valid
  end

  it "Accepts positive run times" do
    run_log = RunLog.new
    run_log.time_ran = 30
    run_log.should be_valid
  end

  pending "Test if date is today's date"

end
