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

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
