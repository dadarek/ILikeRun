require 'spec_helper'

describe ApplicationController do

  it "has an authenticate before filter" do
    all_filters = ApplicationController._process_action_callbacks
    before_filters = all_filters.select{|f| f.kind == :before }
    filter_names =before_filters.map(&:filter) 

    filter_names.should include(:ensure_is_logged_in)
  end

  it "redirects to login if not authenticated" do
    c = ApplicationController.new
    pending "The below does not work"
    #c.ensure_is_logged_in.should redirect_to(:users_login)
  end

end
