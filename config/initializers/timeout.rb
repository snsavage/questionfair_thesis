# Source: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server
if Rails.env.production?
  # config/initializers/timeout.rb
  Rack::Timeout.timeout = 20  # seconds
end
