class WelcomeController < ApplicationController
  
  layout 'welcome'

  # before_filter :authenticate_user!
  skip_authorization_check

  def index

  end

end