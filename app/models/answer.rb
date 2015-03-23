class Answer < ActiveRecord::Base
  
  belongs_to :user, touch: true
  belongs_to :question, touch: true, counter_cache: true

  has_many :answer_votes

  validates :question, presence: true
  validates :answer, presence: true
  validates :answer, length: { maximum: 500 } 
  validates :answer, uniqueness: {scope: :question_id, 
    message: "cannot be provided more than once, but you can vote on an answer that you like."}
  validate :ensure_only_one_answer

  def voter_list
    User.select("id","nickname").find(self.answer_votes.pluck(:user_id))
  end

  def ensure_only_one_answer
    errors.add :user_id, "cannot answer a question more than once." if Question.find(question_id).answers.find_by(user_id: user_id).present?
  end


end
