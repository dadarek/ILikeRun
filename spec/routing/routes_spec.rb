require 'spec_helper'

describe "first route test" do

  it "does not route anything" do
    { get: "/" }.should_not be_routable
  end

end

