class UsersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  add_breadcrumb "Home", :root_path

  # Actions for Friends Auto Complete.  Returns JSON. 
  def index
    @nicknames = User.select(:nickname).where("nickname ILIKE ?", "%#{params[:term]}%").order(:nickname)
    respond_to do |format|
      format.json { render json: @nicknames.map(&:nickname) }
      format.html { redirect_to root_path }
    end
  end

  # User profile pages. 
  def show

    @user = User.find(params[:id])
    if @user.friends_with(current_user)
      @questions = @user.questions.order(created_at: :desc)
      @answers = @user.answers.includes(:question).order(created_at: :desc)
      @points = @user.points.sum(:points)
      add_breadcrumb @user.nickname, :user_path
      render 'show'
    else
      redirect_to root_path, notice: "You are not friends with this user."
    end

  end


end