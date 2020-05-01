source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'dotenv-rails', groups: [:development, :test], require: 'dotenv/rails-now'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.2', '>= 6.0.2.2'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'pg'
gem 'sequel-rails'

gem 'lograge'
gem 'logstash-event'
gem 'sentry-raven'

gem 'sidekiq'

gem 'dry-rails'
gem 'dry-monads'
gem 'dry-view'
gem 'dry-cli'
gem 'dry-events'

gem 'devise'
gem 'sequel-devise'
gem 'devise-bootstrap-views', '~> 1.0'
gem 'devise-token_authenticatable'

gem 'youtube-dl.rb'

gem 'slim-rails'
gem 'builder'
gem 'mimemagic'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'
  gem 'amazing_print'

  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :development do
  # Preview mail in the browser instead of sending
  gem 'letter_opener'

  # Debug I18n keys
  # gem 'i18n-debug'

  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'better_errors'
  gem 'binding_of_caller'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
