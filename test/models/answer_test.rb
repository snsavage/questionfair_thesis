# == Schema Information
#
# Table name: answers
#
#  id                 :integer          not null, primary key
#  answer             :text
#  question_id        :integer
#  created_at         :datetime
#  updated_at         :datetime
#  user_id            :integer
#  best               :boolean          default(FALSE)
#  answer_votes_count :integer          default(0)
#

require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
