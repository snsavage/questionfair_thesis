class Question < ActiveRecord::Base

  include PgSearch

  belongs_to :user, touch: true
  has_many :answers 
  has_many :answer_votes, through: :answers

  CATEGORIES = %w(Entertainment Hotels Movies Other Restaurants Shopping 
                    Sports  Technology Television Vacations Books)

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

  def self.category_list_with_all
    CATEGORIES + ["All"]
  end

  def self.category_in_categories?(category)
    category_list.include?(category) ? true : false
  end

  scope :search, -> search { 
    # where("question ILIKE ? OR category ILIKE ?", "%#{search}%", "%#{search}%")
    where("question @@ ? OR category @@ ?", search, search)
  }

  pg_search_scope :search_all, 
    against: [:question, :category], 
    associated_against: { answers: :answer },
    using: { tsearch: { any_word: true } }
    #using: [:tsearch, :trigram, :dmetaphone]


end
