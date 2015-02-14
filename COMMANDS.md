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

