# == Schema Information
#
# Table name: points
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  action          :string(255)
#  rewardable_id   :integer
#  rewardable_type :string(255)
#  description     :string(255)
#  points          :integer
#  created_at      :datetime
#  updated_at      :datetime
#

require 'test_helper'

class PointTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
