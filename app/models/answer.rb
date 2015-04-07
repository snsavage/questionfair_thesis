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

class Answer < ActiveRecord::Base

  include PublicActivity::Common
  
  # Answer associations.
  belongs_to :user, touch: true
  belongs_to :question, touch: true, counter_cache: true
  has_many :answer_votes

  # Answer validations. 
  validates :question, presence: true
  validates :answer, presence: true
  validates :answer, length: { maximum: 500 } 
  validates :answer, uniqueness: {scope: :question_id, 
    message: "cannot be provided more than once, but you can vote on an answer that you like."}
  # validate :ensure_only_one_answer 

  # List of votes for a given answer.
  def voter_list
    User.select("id","nickname").find(self.answer_votes.pluck(:user_id))
  end


  # def ensure_only_one_answer
  #   errors.add :user_id, "cannot answer a question more than once." if Question.find(question_id).answers.find_by(user_id: user_id).present?
  # end

  # Determines if given answer is the best answer.
  def best_answer?
    best == true
  end

end
