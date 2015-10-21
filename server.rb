require "sinatra"
require "sinatra/reloader"
# We're going to need to require our class files
require_relative "./lib/task.rb"
require_relative "./lib/todoList.rb"

todo_list = Todolist.new("Josh")
todo_list.load_tasks

get "/tasks" do
	@todo = todo_list
	erb(:task_index)
end

post "/new_task" do
	@content = params[:content]
	newtask = Task.new(@content)
	todo_list.add_task(newtask)
	redirect "tasks"
end