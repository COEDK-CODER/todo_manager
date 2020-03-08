class Todo < ActiveRecord::Base
  def to_formatted_string
    status = completed ? "[x]" : "[]"
    "#{id} #{due_date.to_s(:long)} #{todo_text} #{status}"
  end
end
