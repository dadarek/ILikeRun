# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["USE_JASMINE_RAKE"] = "true"
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false
end

def create_user(user_name = "John", password = "Smith")
  User.create!(user_name: user_name, password: password)
end

def login user
  session = {user_id: user.id}
  @controller.stub(:session).and_return(session)
end

def create_run_log(date_ran = Date.today, time_ran = 30, user = @user)
  RunLog.create!(date_ran: date_ran, time_ran: time_ran, user_id: user.id)
end

def stub_views_current_user user
  @view.stub(:current_user).and_return(user)
end

