require "date"

class Todo < ActiveRecord::Base
  belongs_to :user
  validates :todo_text, presence: true
  validates :todo_text, length: { minimum: 2 }
  validates :due_date, presence: true

  def to_formatted_string
    status = completed ? "[x]" : "[]"
    "#{id} #{due_date.to_s(:long)} #{todo_text} #{status}"
  end

  def self.of_user(user)
    all.where(user_id: user.id)
  end

  def overdue?
    due_date < Date.today and self.todo_status
  end

  def todo_status
    self.completed
  end

  def self.overdue
    all.where("due_date < ? and completed=?", Date.today, false)
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
