require 'spec_helper'

describe "route tests" do

  it "only allows new and create" do
    { post: "/run_logs" }.should route_to(
      controller: "run_logs",
      action: "create"
    )

    { get: "/run_logs/new" }.should route_to(
      controller: "run_logs",
      action: "new"
    )

    {get: "/run_logs/54"}.should_not be_routable
    {get: "/run_logs/54/edit"}.should_not be_routable
    {put: "/run_logs/54"}.should_not be_routable
    {delete: "/run_logs/54"}.should_not be_routable

  end

end

