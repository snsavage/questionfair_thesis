class Mailer < ActionMailer::Base

  # Mailer for Contact Form.
  def contact(message)
    @message = message
    mail :to => "contact@questionfair.com", :from => @message.email, :subject => "#{@message.subject} - Contact from #{@message.name}"
  end

end