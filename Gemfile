source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1', '>= 5.2.1.1'
# Use sqlite3 as the database for Active Record
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootstrap-datepicker-rails'
gem "bootstrap_form", ">= 4.0.0"

gem 'pg'
gem 'sassc-rails', '>= 2.0.0'
gem 'material-sass', '4.1.1'
gem "font-awesome-rails"
gem 'bootsnap', '>= 1.1.0', require: false
gem 'ckeditor'
gem 'font-awesome-rails'
gem 'material_icons'
gem 'activeadmin'
gem 'sprockets-rails', :require => 'sprockets/railtie'
gem 'cancancan', '~> 2.0'
gem 'faker', :git => 'https://github.com/stympy/faker.git', :branch => 'master'
gem 'momentjs-rails', '>= 2.9.0'

gem 'factory_bot_rails'
gem 'will_paginate', '~> 3.1.0'
gem 'will_paginate-bootstrap'
gem 'delayed_job_active_record'

gem 'delayed-web'
gem 'concurrent-ruby', require: 'concurrent'
gem 'searchkick'
gem "daemons"
gem "interactor", "~> 3.0"
gem 'jquery-rails'
gem 'ancestry'
gem 'omniauth', '~> 1.6', '>= 1.6.1'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'russian', '~> 0.6.0'
gem 'devise'
gem 'simple_form'
gem 'execjs'
gem 'date_wrapper'
gem 'elasticsearch-rails'
gem 'elasticsearch-model'
gem 'ransack', github: 'activerecord-hackery/ransack'

gem "paperclip", "~> 6.0.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :production do
 # gem 'pg', '~> 0.18.4'
  gem 'rails_12factor'
end 

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem "letter_opener"
 # gem 'sqlite3'
  gem 'pry-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'bullet'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem "factory_bot_rails"
  gem 'rspec-rails'
  gem 'rails-controller-testing'
  gem 'rspec'       # for rspec-core, rspec-expectations, rspec-mocks
  gem 'rspec-mocks' # for rspec-mocks only
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
