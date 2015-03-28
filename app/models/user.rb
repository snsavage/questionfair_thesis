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

  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user

  validates :nickname, uniqueness: { case_sensitive: false }
  validates :nickname, presence: true
  validates :nickname, length: { minimum: 2 }
  validates :nickname, length: { maximum: 15 }

  validates :terms, acceptance: { accept: true, message: "of Service and Privacy Policy must be agreed to in order to create an account." }
  validates :mail_chimp, inclusion: [true, false]

  # Source: http://railscasts.com/episodes/106-time-zones-revised
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.us_zones.map(&:name) }

  after_save :mailchimp_status

  # Source: https://github.com/scambra/devise_invitable/wiki/Disabling-devise-recoverable,-if-invitation-was-not-accepted
  def send_reset_password_instructions
    super if invitation_token.nil?
  end


  # Source: http://mrgeorgegray.com/workflow/getting-a-grip-on-gibbon/
  def mailchimp_status
    @mailchimp_list_id = ENV['MAILCHIMP_LIST_ID']
    @gb = Gibbon::API.new

    if self.mail_chimp == true
      @gb.lists.subscribe({
      :id => @mailchimp_list_id,
      :email => {:email => self.email},
      :merge_vars => {:NICKNAME => self.nickname},
      :double_optin => false,
      :send_welcome => true
    })
    elsif self.mail_chimp == false
      @gb.lists.unsubscribe({
      :id => @mailchimp_list_id,
      :email => {:email => self.email},
      :delete_member => true,
      :send_goodbye => true,
      :send_notify => false
    })
    end
  end

end




