class UsersController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @nicknames = User.where("nickname ILIKE ?", "%#{params[:term]}%")
    render json: @nicknames.map(&:nickname)
  end

  def show
    @user = User.find(params[:id])
  end


end