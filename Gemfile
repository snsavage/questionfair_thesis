# This is sometimes needed to get Postgres running. 
# env ARCHFLAGS="-arch x86_64" gem install pg -- --with-pg-config=/Applications/Postgres.app/Contents/Versions/9.4/bin/pg_config

source 'https://rubygems.org'

ruby '2.2.0' 
gem 'rails', '4.1.8'

gem 'pg'
gem 'pg_search'

gem 'puma'
gem "rack-timeout", group: :production
gem 'rails_12factor', group: :production

gem 'devise'
gem 'devise_invitable', '~> 1.3.4'
# gem 'devise_campaignable'

gem 'cancancan', '~> 1.10'

gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap'

gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.3.3'

gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'

gem 'geocoder'
gem 'breadcrumbs_on_rails'

gem 'gibbon'
gem 'public_activity'

gem 'google-analytics-rails'
gem 'newrelic_rpm'

group :development, :test do
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'rack-mini-profiler'
  gem 'rails-erd'
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'faker'
  gem 'quiet_assets'
  gem 'bullet'
  gem 'letter_opener'
end

group :test do
  gem 'minitest-reporters'
  gem 'capybara'
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers'
  gem "factory_girl_rails", "~> 4.0"
  gem "codeclimate-test-reporter", require: nil
end

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
