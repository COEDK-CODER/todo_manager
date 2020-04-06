require "date"

class Todo < ActiveRecord::Base
  def to_formatted_string
    status = completed ? "[x]" : "[]"
    "#{id} #{due_date.to_s(:long)} #{todo_text} #{status}"
  end

  def self.overdue
    all.where(" due_date< ?", Date.today)
  end

  def self.due_today
    all.where("due_date = ?", Date.today)
  end

  def self.due_later
    all.where("due_date> ?", Date.today)
  end
  def self.completed
    all.where("completed= ?", true)
  end
end
