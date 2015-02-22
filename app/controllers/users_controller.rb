class UsersController < ApplicationController

  before_filter :authenticate_user!

  def index

    if user_signed_in?
      @questions = Question.where(user_id: current_user.id)
      @answers = Answer.where(user_id: current_user.id)
    else
      render 'questions#index'
    end


  end



end