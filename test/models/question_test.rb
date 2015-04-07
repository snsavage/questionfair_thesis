# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question      :text
#  category      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  answers_count :integer          default(0)
#  address       :string(255)
#  city          :string(255)
#  state         :string(255)
#  country       :string(255)
#  latitude      :float
#  longitude     :float
#  city_state    :string(255)
#

require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  



end
