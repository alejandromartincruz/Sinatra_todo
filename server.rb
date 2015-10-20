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