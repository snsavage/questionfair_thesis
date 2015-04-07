# Formatter for Devise error messages with Bootstrap.
# Source: https://github.com/plataformatec/devise/wiki/Override-devise_error_messages!-for-views

module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => resource.errors.count,
                      :resource => resource.class.model_name.human.downcase)

    # <h4>#{sentence}</h4>

    html = <<-HTML
    <div class="col-md-12" id="error_explanation">
      <div class="alert alert-danger" role="alert">
        <span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
        <span class="sr-only">Error:</span>
        #{sentence}
        <ul>#{messages}</ul>
      </div>
    </div>

    <hr />

    HTML

    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end
