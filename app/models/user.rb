class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :questions
  has_many :answers

  validates :nickname, uniqueness: true
  validates :nickname, presence: true
  validates :nickname, length: { minimum: 2 }
  validates :nickname, length: { maximum: 15 }

  # Code from http://railscasts.com/episodes/106-time-zones-revised
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.us_zones.map(&:name) }

end
