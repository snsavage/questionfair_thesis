class DashboardController < ApplicationController

  before_filter :authenticate_user!
  skip_authorization_check

  add_breadcrumb "Home", :root_path

  def index

    add_breadcrumb "Dashboard", :dashboard_index_path

    # Dashboard Index.  Instantiates need variables for dashboard 
    # display.  
    if user_signed_in?
      @questions = current_user.questions.all.order(created_at: :desc)
      @answers = current_user.answers.includes(:question).all.order(created_at: :desc)
      @user = current_user
      @friendship = current_user.friendships.build
      @points = current_user.points.order(created_at: :desc)
      @total_points = current_user.points.sum(:points)
      @activities = PublicActivity::Activity.includes(:trackable, :owner).order(created_at: :desc).where(owner_id: current_user.friend_ids, owner_type: "User")
    else
      render 'questions#index'
    end

  end

end
