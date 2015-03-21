class FriendshipsController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource

  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      redirect_to dashboard_index_path(anchor: "friends"), notice: "Added friend."
    else
      redirect_to dashboard_index_path(anchor: "friends"), error: "Unable to add this friendship."
    end
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to dashboard_index_path(anchor: "friends"), notice: "Removed friend."
  end

end


