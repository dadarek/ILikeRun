source 'https://rubygems.org'

gem 'rails', '3.2.3'

group :test, :development do
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end


group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem 'jquery-rails'
  gem 'jquery-ui-rails'
end

group :test, :development do
  gem "rspec-rails", "~> 2.6"
end

gem "capybara"

group :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner"
  gem 'jasmine'
end

gem 'bcrypt-ruby', require: 'bcrypt'

