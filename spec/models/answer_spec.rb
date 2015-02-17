require 'rails_helper'

describe Answer do
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


