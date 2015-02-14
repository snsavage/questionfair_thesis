FactoryGirl.define do  factory :user do
    nickname "MyString"
first_name "MyString"
last_name "MyString"
  end


  factory :question do
    question "A question?"
    category "Other"
  end

  factory :answer do
    association :question
    answer "An answer!"
  end


end