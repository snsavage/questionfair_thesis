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

require 'rails_helper'

RSpec.describe Question do
  it "is valid with a valid question and category" do
    question = build(:question)
    expect(question).to be_valid
  end

  it "is invalid without a question" do
    question = build(:question, question: nil)
    expect(question).to_not be_valid
  end

  it "is invalid witout a category" do
    question = build(:question, category: nil)
    expect(question).to_not be_valid
  end

  it "has a maximum lenght of 500 chars" do
    question = Question.new(question: 'a' * 501, category: 'Other')
    expect(question).to_not be_valid
  end

  it "has a complete category list" do
    categories = %w(Entertainment Hotels Movies Other Restaurants Shopping 
                    Sports  Technology Television Vacations)
    expect(Question::CATEGORIES).to match_array(categories)
  end

  it "is invalid with category not in CATEGORIES" do
    question = Question.new(question: "A question?", category: "Missing Categoty")
    expect(question).to_not be_valid
  end

  it "has_many answers" do
    is_expected.to have_many(:answers)
  end

  it "begins with Who, What, Where, Why, When, or How"


end
