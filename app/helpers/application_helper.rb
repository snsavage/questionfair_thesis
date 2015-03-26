module ApplicationHelper


  # Code from https://gist.github.com/suryart/7418454
  BOOTSTRAP_FLASH_MSG = {
    success: 'success',
    error: 'danger',
    alert: 'warning',
    notice: 'info'
  }

  def bootstrap_class_for(flash_type)
    BOOTSTRAP_FLASH_MSG[flash_type.to_sym]
  end

  # Code from http://railscasts.com/episodes/244-gravatar
  def gravatar_url(user)
    default_url = "#{root_url}images/badge-orange.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end

end
