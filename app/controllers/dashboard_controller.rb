class DashboardController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  def index

    if user_signed_in?
      @questions = current_user.questions.all
      @answers = current_user.answers.all
    else
      render 'questions#index'
    end

  end



end
