class StaticController < ApplicationController
  
  layout 'welcome', only: :welcome

  # before_filter :authenticate_user!
  skip_authorization_check

  def welcome
    


  end

end