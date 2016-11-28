module DeviseHelper
  def devise_error_messages_alert!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = add_html_to_error_message_alert(messages, sentence)

    html.html_safe
  end

  def add_html_to_error_message_alert(messages, sentence)
    <<-HTML
   <div style="display: block;" class="alert alert-danger info">
      <a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
      <strong>#{sentence}</strong>
      <ul>#{messages}</ul>
   </div>
    HTML
  end
end
