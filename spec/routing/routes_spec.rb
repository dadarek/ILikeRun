require 'spec_helper'

describe "route tests" do

  it "run_logs only allows new, create and list" do
    {post: "/run_logs"}.should route_to "run_logs#create"
    {get: "/run_logs"}.should route_to "run_logs#index"
    {get: "/run_logs/new"}.should route_to "run_logs#new"

    {get: "/run_logs/54"}.should_not be_routable
    {get: "/run_logs/54/edit"}.should_not be_routable
    {put: "/run_logs/54"}.should_not be_routable
    {delete: "/run_logs/54"}.should_not be_routable
  end

  it "allows get, post, and delete schedules" do
    {get: "/schedules"}.should route_to "schedules#index"
    {post: "/schedules"}.should route_to "schedules#create"
    {delete: "/schedules"}.should route_to "schedules#destroy"
  end

  it "user only allows get and post to login" do
    {get: "/users/login"}.should route_to "users#login"
    {post: "/users/login"}.should route_to "users#authenticate"
  end

  it "user allows get to logout" do
    {get: "/users/logout"}.should route_to "users#logout"
  end

  it "routes root to login page" do
    { get: "/" }.should route_to("users#login")
  end

end

