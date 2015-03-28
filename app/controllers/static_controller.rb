class StaticController < ApplicationController

  # before_filter :authenticate_user!
  skip_authorization_check

  add_breadcrumb "Home", :root_path, only: [:about, :contact, :privacy, :terms]

  def welcome

  end

  def about
    add_breadcrumb "About", :about_path
  end

  def contact
    add_breadcrumb "Contact", :contact_path

    @contact_message = EmailMessage.new
    if current_user
      @contact_message.name = current_user.nickname
      @contact_message.email = current_user.email
      if params[:from] == "Category Suggestion"
        @contact_message.subject = "Category Suggestion for QuestionFair.com"
      else
        @contact_message.subject = "Contacting QuestionFair.com"
      end
    else
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
    add_breadcrumb "Privacy Policy", :privacy_path
  end

  def terms
    add_breadcrumb "Terms of Service", :terms_path
  end

  private
    def contact_params
      params.require(:email_message).permit(:name, :email, :subject, :content)
    end 

end