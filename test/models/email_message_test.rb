# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  subject    :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

require 'test_helper'

class EmailMessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
