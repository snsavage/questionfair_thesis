class StaticController < ApplicationController

  # before_filter :authenticate_user!
  skip_authorization_check

  def welcome
  end

  def about
  end

  def contact
    @contact_message = EmailMessage.new
    if current_user
      @contact_message.name = current_user.nickname
      @contact_message.email = current_user.email
      if params[:from] == "Category Suggestion"
        @contact_message.subject = "Category Suggestion for QuestionFair.com"
      else
        @contact_message.subject = "Contacting QuestionFair.com"
      end
    end
  end

  def contact_messages
    if params[:email].present?
      redirect_to root_url, notice: "Your message was marked as spam.  
        Don't fill in the invisable email field.  Please try again."
    else
      @contact_message = EmailMessage.new(contact_params)
      if @contact_message.save
        Mailer.contact(@contact_message).deliver
        redirect_to root_url, :notice => "Thank you for contacting QuestionFair."
      else
        render :contact
      end
    end

  end

  def privacy
  end

  def terms
  end

  private
    def contact_params
      params.require(:email_message).permit(:name, :email, :subject, :content)
    end 

end