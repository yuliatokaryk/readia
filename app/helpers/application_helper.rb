module ApplicationHelper
  def sidebar_link_active_class(link_name)
    return "" unless link_name == controller_name.to_sym

    "sidebar-link-active"
  end
end
