require 'spec_helper'

describe "users/login" do

  it "renders alert when alert present" do
    flash[:alert] = "Some alert."
    render
    rendered.should have_selector(".alert")
    rendered.should =~ /Some alert\./
  end

end
