FactoryGirl.define do  

  factory :user do
    nickname "MyString"
    first_name "MyString"
    last_name "MyString"
  end


  factory :question do
    question "A question?"
    category "Other"

    factory :invalid_question do
      question nil
      category nil
    end

  end

  factory :answer do
    association :question
    answer "An answer!"

    factory :invalid_answer do
      answer nil
    end
  end

end