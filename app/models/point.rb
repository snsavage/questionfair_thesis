class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :rewardable, polymorphic: true

  def self.values
    { ask: 10,
      answer: 10,
      vote: 5,
      best_question: 5,
      best_answer: 15, 
      best_vote: 5,
      invite: 5,
      friend_request: 5,
      friend_confirm: 5 }
  end

  def self.description_text
    { ask: "Asked a question.",
      answer: "Answered a question.",
      vote: "Voted on a answer.",
      best_question: "Selected the best answer for your question.",
      best_answer: "Provided the best answer to a question.", 
      best_vote: "Voted on the best answer to a question.",
      invite: "Invited a friend to join QuestionFair.com.",
      friend_request: "Requested a friendship.",
      friend_confirm: "Confirmed a friendship."}
  end

end
