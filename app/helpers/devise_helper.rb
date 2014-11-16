module DeviseHelper

  # CHECK IF THERE ARE DEVISE ERRORS AND THEN INCLUDE ERROR MESSAGES ON DEVISE PAGES
  # ====================================================================================================
  def devise_error_messages!
    return '' if resource.nil?
    return '' if resource.errors.nil?
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
      <div class="alert alert-warning">
        #{messages}
      </div>
    HTML

    html.html_safe
  end

end