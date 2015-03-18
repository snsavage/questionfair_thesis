class Answer < ActiveRecord::Base
  
  belongs_to :user, touch: true
  belongs_to :question, touch: true, counter_cache: true

  has_many :answer_votes

  validates :question, presence: true
  validates :answer, presence: true
  validates :answer, length: { maximum: 500 } 

  def voter_list
    User.select("id","nickname").find(self.answer_votes.pluck(:user_id))
  end

end
