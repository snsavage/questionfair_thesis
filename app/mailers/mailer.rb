class Mailer < ActionMailer::Base
  def contact(message)
    @message = message
    mail :to => "contact@questionfair.com", :from => @message.email, :subject => "#{@message.subject} - Contact from #{@message.name}"
  end

  # def comment_response(comment, user)
  #   @comment = comment
  #   @user = user
  #   mail :to => @user.email, :from => "noreply@railscasts.com", :subject => "Comment Response on RailsCasts"
  # end
end