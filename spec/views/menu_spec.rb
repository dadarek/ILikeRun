require 'spec_helper'

describe "layouts/_menu" do

  def have_logout 
    have_selector "a[href='#{logout_path}']"
  end

  it "renders logout link if user present" do
    session[:user_id] = 5
    render
    rendered.should have_logout
  end

  it "does not render logout link if user not present" do
    render
    rendered.should_not have_logout
  end

end
