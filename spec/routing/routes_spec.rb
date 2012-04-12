require 'spec_helper'

describe "first route test" do

  it "routes index to run_logs controller" do
    { get: "/" }.should route_to "run_logs#index"
  end

end

