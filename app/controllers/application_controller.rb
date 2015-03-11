class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  around_filter :set_time_zone

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:nickname, :time_zone]
      devise_parameter_sanitizer.for(:account_update) << [:time_zone]
    end

    def set_time_zone
      if user_signed_in?
        Time.use_zone(current_user.time_zone) { yield }
      else
        yield
      end
    end

end
