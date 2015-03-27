class UsersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  add_breadcrumb "Home", :root_path

  def index
    @nicknames = User.select(:nickname).where("nickname ILIKE ?", "%#{params[:term]}%").order(:nickname)
    respond_to do |format|
      format.json { render json: @nicknames.map(&:nickname) }
      format.html { redirect_to root_path }
    end
  end

  def show

    @user = User.find(params[:id])

    add_breadcrumb @user.nickname, :user_path

  end


end