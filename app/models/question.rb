class Question < ActiveRecord::Base

  has_many :answers 

  CATEGORIES = %w(Entertainment Hotels Movies Other Restaurants Shopping 
                    Sports  Technology Television Vacations)

  validates :question, :category, presence: true
  validates :question, length: { maximum: 500 }
  validates :category, inclusion: { in: CATEGORIES }

end