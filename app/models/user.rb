class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :questions
  has_many :answers

  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  has_many :answer_votes

  validates :nickname, uniqueness: true
  validates :nickname, presence: true
  validates :nickname, length: { minimum: 2 }
  validates :nickname, length: { maximum: 15 }

  # Source: http://railscasts.com/episodes/106-time-zones-revised
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.us_zones.map(&:name) }

  # Source: https://github.com/scambra/devise_invitable/wiki/Disabling-devise-recoverable,-if-invitation-was-not-accepted
  def send_reset_password_instructions
    super if invitation_token.nil?
  end

end
