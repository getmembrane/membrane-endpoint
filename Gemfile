source 'https://rubygems.org'
ruby '2.3.1'

gem 'rails', '4.2.4'
gem 'pg'
gem 'active_model_serializers', '~> 0.10.0'
gem 'bcrypt'
gem 'pundit'
gem 'rack-cors'

group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "rspec-rails", "~> 2.14"
  gem "factory_girl_rails"
  gem 'ffaker'
  gem "shoulda-matchers"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'spring'
end

group :production do
  gem "rails_12factor"
end

gem 'puma'
