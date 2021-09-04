module ApplicationHelper
  def format_date(due_date)
    due_date.strftime('%b %d, %Y')
  end

  def today(tasks)
    tasks.where(due_at: Date.today).order(due_at: :asc)
  end

  def overdue(tasks)
    tasks.where(['due_at < ?', Date.today]).order(due_at: :asc)
  end

  def upcoming(tasks)
    tasks.where(['due_at > ?', Date.today]).order(due_at: :asc)
  end

  def current_class?(test_path)
    return 'active' if request.path == test_path
    ''
  end
end
