require 'spec_helper'

describe RunLog do

  it "Saves time_ran" do
    run_log = RunLog.create!( time_ran: 30 )
    run_log.time_ran.should == 30
  end

end
