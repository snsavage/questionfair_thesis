class Question < ActiveRecord::Base

  belongs_to :user, touch: true
  has_many :answers 

  CATEGORIES = %w(All Entertainment Hotels Movies Other Restaurants Shopping 
                    Sports  Technology Television Vacations)

  validates :question, :category, presence: true
  validates :question, length: { maximum: 500 }
  validates :category, inclusion: { in: CATEGORIES }

  # Source: http://blog.plataformatec.com.br/2013/02/active-record-scopes-vs-class-methods/
  scope :by_category, -> category { 
    if category == "All"
      all
    elsif category_in_categories?(category)
      where(category: category)
    else
      all
    end
  }

  def self.category_list
    CATEGORIES
  end

  def self.category_in_categories?(category)
    category_list.include?(category) ? true : false
  end

end
