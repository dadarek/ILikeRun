require 'spec_helper'

describe "index page" do

  it "displays success after a log post" do
    get "/"

    assert_select "form.add_run" do
      assert_select "input[name=?]", "time_ran"
      assert_select "input[type=?]", "submit"
    end

    post "/", time_ran: 30
    assert_select ".message", text: "Success"
  end

end
