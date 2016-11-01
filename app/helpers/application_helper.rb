module ApplicationHelper

  def nav_link(link_text, link_path)
    from = Rails.application.routes.recognize_path(request.url)
    path = Rails.application.routes.recognize_path(link_path)

    class_name = %w(nav-item) << (from[:controller] == path[:controller] ? 'active' : '')
    content_tag :li, class: class_name.join(' ') do
      link_to link_text, link_path, class: 'nav-link'
    end
  end

end
