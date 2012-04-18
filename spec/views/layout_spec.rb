require 'spec_helper'

describe "layouts/application" do

  it "should not render welcome text if user present" do
    render
    rendered.should_not have_selector ".welcome-text"
  end
  
  it "should render welcome text if user present" do
    assign(:user, User.new)
    render
    rendered.should have_selector ".welcome-text"
  end

end
