require 'spec_helper'

describe "layouts/application" do

  it "should not render welcome text if user present" do
    render
    rendered.should_not have_selector ".welcome-text"
  end
  
  it "should render welcome text if user present" do
    session[:user_id] = 5
    render
    rendered.should have_selector ".welcome-text"
  end

end
