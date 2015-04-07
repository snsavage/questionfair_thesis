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

require 'rails_helper'

RSpec.describe Answer do
  it "is valid with a valid question" do
    answer = build(:answer)
    expect(answer).to be_valid
  end

  it "belongs to question" do
    is_expected.to belong_to(:question)
  end

  it "has a question_id" do
    is_expected.to validate_presence_of(:question)
  end

  it "has an answer" do
    answer = build(:answer, answer: nil)
    expect(answer).to_not be_valid
  end

  it "has maximum lenghth of 500 chars" do
    answer = build(:answer, answer: 'q'*501)
    expect(answer).to_not be_valid
  end

end


