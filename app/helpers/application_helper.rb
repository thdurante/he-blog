module ApplicationHelper
  def current_active_menu(path)
    current_page?(path) ? 'active' : ''
  end

  def format_date(date)
    date.strftime('%d/%m/%Y') unless date.nil?
  end

  def format_datetime(datetime)
    datetime.strftime('%d/%m/%Y') unless datetime.nil?
  end
end
