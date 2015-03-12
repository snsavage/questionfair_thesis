# Source: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server

# config/initializers/timeout.rb
Rack::Timeout.timeout = 20  # seconds
