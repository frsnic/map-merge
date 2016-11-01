module ApplicationHelper

  def nav_link(link_text, link_path)
    from_control = Rails.application.routes.recognize_path(request.url)[:controller].split('/')[0]
    path_control = Rails.application.routes.recognize_path(link_path)[:controller].split('/')[0]

    class_name = %w(nav-item) << (from_control == path_control ? 'active' : '')
    content_tag :li, class: class_name.join(' ') do
      link_to link_text, link_path, class: 'nav-link'
    end
  end

end
