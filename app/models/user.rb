# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  nickname               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  time_zone              :string(255)      default("Eastern Time (US & Canada)")
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  mail_chimp             :boolean          default(FALSE)
#  terms                  :boolean          default(FALSE)
#

class User < ActiveRecord::Base
  # Devise modules. 
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  # User associations. 
  has_many :questions
  has_many :answers
  has_many :invitations, :class_name => self.to_s, :as => :invited_by
  has_many :answer_votes
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  has_many :points

  # User validations.  
  validates :nickname, uniqueness: { case_sensitive: false }
  validates :nickname, presence: true
  validates :nickname, length: { minimum: 2 }
  validates :nickname, length: { maximum: 15 }

  validates :terms, acceptance: { accept: true, message: "of Service and Privacy Policy must be agreed to in order to create an account." }
  validates :mail_chimp, inclusion: [true, false]

  # Source: http://railscasts.com/episodes/106-time-zones-revised
  validates :time_zone, inclusion: { in: ActiveSupport::TimeZone.us_zones.map(&:name) }

  after_save :mailchimp_status

  # Code required for Devise Invitable.
  # Source: https://github.com/scambra/devise_invitable/wiki/Disabling-devise-recoverable,-if-invitation-was-not-accepted
  def send_reset_password_instructions
    super if invitation_token.nil?
  end

  # Determines if users are friends. 
  def friends_with(user)
    if user.nil?
      false
    else
      self.friendships.confirmed.where(friend_id: user.id).exists?
    end
  end

  # Add and Removes a User of the Mail Chimp Newsletter
  # depending on user profile preference. 
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




