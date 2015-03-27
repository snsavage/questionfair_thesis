class AnswerVote < ActiveRecord::Base

  # Source: http://railscasts.com/episodes/364-active-record-reputation-system
  belongs_to :answer, touch: true, counter_cache: true
  belongs_to :user, touch: true

  validates :user_id, uniqueness: {scope: :answer_id, message: "You may only vote on an answer once."}
  validate :ensure_not_asker
  validate :ensure_only_one_vote

  def ensure_not_asker
    errors.add :user_id, "cannot vote on their own question." if answer.user_id == user_id
  end

  def ensure_only_one_vote
    errors.add :user_id, "cannot vote on more than one answer." if Question.find(answer.question_id).answer_votes.find_by(user_id: user_id).present?
  end





end
