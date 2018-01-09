module HtmlHelper
  def spinner_css
    content_tag :div, class: 'sk-block-center' do
      content_tag :div, class: 'sk-cube-grid' do
        content_tag :div, '', class: 'mdl-spinner mdl-spinner--single-color mdl-js-spinner is-active'
      end
    end
  end
end
