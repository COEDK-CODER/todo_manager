class TodosController < ApplicationController
  def index
    @todos = Todo.of_user(current_user)
    render "index"
    #render plain: Todo.order(:due_date).map { |todo| todo.to_formatted_string }.join("\n")
  end

  def show
    render plain: Todo.find(params[:id]).to_formatted_string
  end

  def create
    new_todo = Todo.new(todo_text: params[:todo_text],
                        due_date: params[:due_date],
                        completed: "false",
                        user_id: current_user.id)
    if new_todo.save
      redirect_to todos_path
    else
      flash[:error] = new_todo.errors.full_messages.join(" , ")
      redirect_to todos_path
    end

    #render plain: "A new todo created successfully with ID_NO #{new_todo.id}"
  end

  def update
    todo = Todo.of_user(current_user).find(params[:id])
    todo.completed = params[:completed]
    todo.save!
    redirect_to todos_path
    #render plain: " #{todo.todo_text} is updated successfully.... "
  end

  def destroy
    Todo.of_user(current_user).find(params[:id]).destroy
    redirect_to todos_path
  end
end
