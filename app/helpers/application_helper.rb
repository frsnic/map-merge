module ApplicationHelper

  def nav_link(link_text, link_path, options = nil)
    from_control = Rails.application.routes.recognize_path(request.url)[:controller].split('/')[0]
    path_control = Rails.application.routes.recognize_path(link_path)[:controller].split('/')[0]

    klass = %w(nav-item) << (from_control == path_control ? 'active' : '')
    icon  = content_tag :i, '', class: options[:icon], 'aria-hidden' => true if options.try(:[], :icon)
    content_tag :li, class: klass.join(' ') do
      link_to link_path, class: 'nav-link' do
        link_text = icon ? "#{icon}#{link_text}".html_safe : link_text
      end
    end
  end

end
