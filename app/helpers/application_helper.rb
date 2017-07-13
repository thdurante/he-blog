module ApplicationHelper
  def current_active_menu(path)
    current_page?(path) ? 'active' : ''
  end
end
