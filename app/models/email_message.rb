# == Schema Information
#
# Table name: email_messages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  subject    :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class EmailMessage < ActiveRecord::Base
  # Validations for contact email.
  validates_presence_of :name, :email, :content
end
