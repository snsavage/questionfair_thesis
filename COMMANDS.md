## Starting the Project

Started a new rails project:
	
	> rails new questionfair --database=postgresql -T
	
Setup the database:

	> rake db:create
	> rake db:migrate
	
Added rspec-rails to the Gemfile:

	group :development, :test do
  		gem 'rspec-rails', '~> 3.0'
	end
	
Finished rspec-rails setup:

	bundle install
	rails generate rspec:install
	
This added the ```spec/``` directory.

Spec can be run with the ```bundle exec rspec``` command.  

## The Question Model

	rails generate model Question question:text category:string  
	
	rails generate model Answer answer:text question:references 
	
	rails generate model User nickname:string first_name:string last_name:string
	
	rails generate devise:install
	
	rails generate controller Questions
	

## Devise Instructions
```
sherlock:questionfair sherlock$ rails generate devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
```




