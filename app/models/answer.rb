class Answer < ActiveRecord::Base
  
  belongs_to :user, touch: true
  belongs_to :question, touch: true

  validates :question, presence: true
  validates :answer, presence: true
  validates :answer, length: { maximum: 500 } 

end
