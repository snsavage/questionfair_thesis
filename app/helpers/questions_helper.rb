# Helpers for controlling the Questions Show display logic.
module QuestionsHelper

  # Helper that determines if a user has answered a question. 
  def user_has_answered(answers)
    answers.pluck(:user_id).include?(current_user.id)
  end  

  # Helper that determines if a user has votes on an answer. 
  def voted_on_answer(answer_id)
    Answer.find(answer_id).answer_votes.pluck(:user_id).include?(current_user.id)
  end

  # Helper that determines if a user has votes on any answer
  # for a specific question. 
  def voted_on_question(question)
    question.answer_votes.pluck(:user_id).include?(current_user.id)
  end

end
