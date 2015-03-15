class DashboardController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def index

    if user_signed_in?
      @answers = current_user.answers.all
      @answers = current_user.answers.includes(:question).all
    else
      render 'questions#index'
    end

  end



end
