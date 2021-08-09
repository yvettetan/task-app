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
end
