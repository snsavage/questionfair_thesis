class StaticController < ApplicationController

  # before_filter :authenticate_user!
  skip_authorization_check

  def welcome
  end

  def about
  end

  def contact    
  end

  def privacy
  end

  def terms
  end

end