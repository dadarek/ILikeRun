require 'spec_helper'

describe RunLog do

  it "Rejects nil run times" do
    run_log = RunLog.new
    run_log.created_at = Date.today
    run_log.time_ran = nil
    run_log.should_not be_valid
  end

  it "Rejects 0 run times" do
    run_log = RunLog.new
    run_log.created_at = Date.today
    run_log.time_ran = 0
    run_log.should_not be_valid
  end

  it "Rejects negative run times" do
    run_log = RunLog.new
    run_log.created_at = Date.today
    run_log.time_ran = -30
    run_log.should_not be_valid
  end

  it "Accepts positive run times" do
    run_log = RunLog.new
    run_log.created_at = Date.today
    run_log.time_ran = 30
    run_log.should be_valid
  end

  it "Rejects null dates" do
    run_log = RunLog.new
    run_log.time_ran = 30
    run_log.created_at = nil
    run_log.should_not be_valid
  end

end
