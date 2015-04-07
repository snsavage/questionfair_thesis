class FriendshipsController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource

  # Friendship Update.  Used for confirming a friendship.
  def update

    # Find both the friendship and inverse friendship.  
    @friendship = current_user.friendships.find(params[:id])
    @friendship_inverse = Friendship.find_inverse(@friendship.user_id, @friendship.friend_id)
    
    # Updates confirmation fields.  
    @friendship[:user_confirmed] = true
    @friendship_inverse[:friend_confirmed] = true

    if @friendship.save && @friendship_inverse.save
      reward_points @friendship, :friend_confirm
      redirect_to dashboard_index_path(anchor: "friends"), 
        notice: "Friend confirmed."
    else
      redirect_to dashboard_index_path(anchor: "friends"), 
        notice: "Could not confirm friend at this time."
    end      
  end

  # Creates new unconfirmed friendship.  
  def create

    #Check is the requestd friendship name is a valid user. 
    if User.pluck(:nickname).include?(params[:friendship][:nicknames])

      # Create both friendship records.  
      @nickname = User.find_by(nickname: params[:friendship][:nicknames])
      @friendship = current_user.friendships.build(friend_id: @nickname.id, user_confirmed: true)
      @friend = User.find(@nickname.id)
      @friendship_inverse = @friend.friendships.build(friend_id: current_user.id, friend_confirmed: true)
      
      if @friendship.user_id == @friendship_inverse.user_id
        redirect_to dashboard_index_path(anchor: "friends"), 
          alert: "You cannot friend yourself."
      elsif @friendship.save && @friendship_inverse.save
        reward_points @friendship, :friend_request
        redirect_to dashboard_index_path(anchor: "friends"), 
          notice: "Friendship requested.  Waiting for confirmation."
      else
        redirect_to dashboard_index_path(anchor: "friends"), 
          alert: "Unable to add this friendship."
      end

    else

      redirect_to dashboard_index_path(anchor: "friends"), 
        alert: "Please provide a valid user."

    end
  end

  # Removes both friendship records.  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship_inverse = Friendship.find_inverse(@friendship.user_id, @friendship.friend_id)

    if @friendship.destroy && @friendship_inverse.destroy
      redirect_to dashboard_index_path(anchor: "friends"), 
        notice: "Removed friend."
    else
      redirect_to dashboard_index_path(anchor: "friends"), 
        alert: "Could not remove friend at this time."
    end  
  end

  private
    # Whitelisted friendship parameters. 
    def friendship_params
      params.permit(:id, :nicknames)
    end

end


