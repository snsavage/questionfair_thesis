# == Schema Information
#
# Table name: friendships
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  friend_id        :integer
#  user_confirmed   :boolean          default(FALSE)
#  friend_confirmed :boolean          default(FALSE)
#  created_at       :datetime
#  updated_at       :datetime
#

class Friendship < ActiveRecord::Base

  # Friendship associations.
  belongs_to :user
  belongs_to :friend, class_name: "User"

  #Friendship validations. 
  validates :user_id, uniqueness: { scope: :friend_id }

  # Finds unconfirmed friendships.
  scope :unconfirmed, -> { 
    where(user_confirmed: true, friend_confirmed: false) }

  # Finds friendship waiting for confirmation.
  scope :confirmation_requested, -> { 
    where(user_confirmed: false, friend_confirmed: true) }

  # Finds confirmed and active friendships.
  scope :confirmed, -> { 
    where(user_confirmed: true, friend_confirmed: true) }

  # Find matching friendship.
  scope :find_inverse, ->(user_id, friend_id) { 
    where(user_id: friend_id, friend_id: user_id).first }

  # Used for friendship lookup autocomplete.
  def nicknames
    self.user.nickname.try(:nickname)
  end

end
