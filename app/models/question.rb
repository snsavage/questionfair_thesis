# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  question      :text
#  category      :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  user_id       :integer
#  answers_count :integer          default(0)
#  address       :string(255)
#  city          :string(255)
#  state         :string(255)
#  country       :string(255)
#  latitude      :float
#  longitude     :float
#  city_state    :string(255)
#

class Question < ActiveRecord::Base

  include PgSearch
  include PublicActivity::Common

  # Gets geocoded location from Google and sets database attributes.
  geocoded_by :address do |obj, results|
    if geo = results.first
      obj.city = geo.city
      obj.state = geo.state_code
      obj.country = geo.country_code
      obj.latitude = geo.latitude
      obj.longitude = geo.longitude
      if obj.city.present? && obj.state.present? && obj.country.present?
        obj.city_state = "#{geo.city}, #{geo.state_code}, #{geo.country_code}"
      end
    end
  end

  # Runs after question record has been saved to database.
  after_validation :geocode, if: ->(obj){obj.address.present? and obj.address_changed?}

  # Question associations.
  belongs_to :user, touch: true
  has_many :answers 
  has_many :answer_votes, through: :answers

  # Array of question categories.
  CATEGORIES = ['Automotive','Books','Business','Cooking','Dining','Health & Fitness',
    'Movies & TV','Music','Other','Outdoors','Parenting','Pets','Sports','Technology',
    'Things to Do','Travel']

  # Question validations.
  validates :question, :category, presence: true
  validates :question, length: { maximum: 500 }
  validates :category, inclusion: { in: CATEGORIES }

  # Finds questions in a categories unless all should be returned. 
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

  # Finds questions by location. 
  scope :by_location, -> location, distance { near(location, distance) if location.present? && distance.present? }

  # Creats address for display in views. 
  def create_address
    "#{city}, #{state}, #{country}"
  end

  # Checks if an address is present based on the presense of 
  # a city, state, and country.  This ensures that only valid 
  # locations are displayed.  
  def has_address?
    !city.nil? && !state.nil? && !country.nil?
  end

  # Array of distances for location search. 
  def self.distances
    [[1, 1], [5, 5], [10, 10], [25, 25], [50, 50], [100, 100]]
  end 

  # Acts as cache store for location search.  Prevents unneeded calls
  # to Google Geocoding API. 
  def self.get_stored_location(location)
    location = Question.select(:latitude, :longitude).where(city_state: location).first
  end

  # Returns Question categories. 
  def self.category_list
    CATEGORIES
  end

  # Returns Question categories with "All".
  def self.category_list_with_all
    CATEGORIES + ["All"]
  end

  # Checks if a categories is included in CATEGORIES.
  def self.category_in_categories?(category)
    category_list.include?(category) ? true : false
  end

  # Checks is a Question has a best answer. 
  def has_best_answer?
    answers.where(best: true).exists?
  end

  # scope :search, -> search { 
  #   # where("question ILIKE ? OR category ILIKE ?", "%#{search}%", "%#{search}%")
  #   where("question @@ ? OR category @@ ?", search, search)
  # }

  # Full Text Search Scope for Nil Query.
  # Source: https://github.com/Casecommons/pg_search/issues/49
  def self.full_text(query)
    if query.present?
      search_all(query)
    else
      # No query? Return all records, newest first.
      order("created_at DESC")
    end
  end

  # Full-text search scope.
  pg_search_scope :search_all, 
    against: [:question, :category, :city, :state, :country], 
    associated_against: { answers: :answer },
    using: { tsearch: { any_word: true } }
    #using: [:tsearch, :trigram, :dmetaphone]

end
