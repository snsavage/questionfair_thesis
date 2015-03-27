class DashboardController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  add_breadcrumb "Home", :root_path

  def index

    add_breadcrumb "Dashboard", :dashboard_index_path

    if user_signed_in?
      @questions = current_user.questions.all.order(created_at: :desc)
      @answers = current_user.answers.includes(:question).all
      @user = current_user
      @friendship = current_user.friendships.build
    else
      render 'questions#index'
    end

  end



end
