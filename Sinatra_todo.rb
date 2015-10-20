require 'rspec'
require 'pry'
require 'yaml/store'

class Todolist
	attr_reader :tasks, :user
    
    def initialize(user)
        @todo_store = YAML::Store.new("./public/tasks.yml")
        @tasks = []
        @user = user
    end

    def add_task(task)
    	@tasks.push(task)
    end

    def delete_task(id)
    	@tasks.each_with_index do |item, index|
  			if item.id == id
  				@tasks = @tasks.delete_at(index)
			end
		end
    end

  def find_task_by_id(id)	 
    	single_task = ""
    	@tasks.each do |item|
    		if item.id == id
  				single_task += item.content
  			end
      end
		  single_task		  
	end

  def sort_by_created
    sorted_tasks = @tasks.sort { | task1, task2 | task1.created_at <=> task2.created_at }
  end

  def save
    @todo_store.transaction do 
      @todo_store[@user] = @tasks
    end
  end

  def load_tasks
    file = YAML.load_file(File.join("./public/tasks.yml"))
    file[@user]
  end

end

class Task
	attr_accessor :content, :id, :done, :created_at
    @@current_id = 1
    def initialize(content)
        @content = content
        @id = @@current_id
        @@current_id += 1
        @done = false
        @created_at = Time.now
        @updated_at = nil
    end

    def completed?
   		@done
    end

    def complete!
    	@done=true
    end

    def make_incomplete!
    	@done=false
    end

    def update_content!(content)
    	@updated_at = Time.now
    	@content = content
    end

end


describe Todolist do 

before :each do
	@Todo = Todolist.new("Paco Pil")
	@task1 = Task.new("alguna cosa tendre que hacer")
	@task2 = Task.new("luego hare algo mas")
	@task3 = Task.new("y luego toca descansar")
end

  describe "#CreatingTask" do
    it "Creates a new task and gives back an unique Id" do
      expect(@task1.id).to eq(1)
      expect(@task2.id).to eq(2)
      expect(@task3.id).to eq(3)
    end

    it "It cheack if the task is complete" do
      expect(@task1.done).to eq(false)
      expect(@task2.done).to eq(false)
      expect(@task3.done).to eq(false)
    end

    it "It cheack if the task is complete" do
      expect(@task1.completed?).to eq(false)
      expect(@task2.completed?).to eq(false)
      expect(@task3.completed?).to eq(false)
    end

    it "It marks a task as complete" do
      expect(@task1.complete!).to eq(true)
      expect(@task2.complete!).to eq(true)
      expect(@task3.complete!).to eq(true)
    end

    it "It marks a task as complete" do
      expect(@task1.make_incomplete!).to eq(false)
      expect(@task2.make_incomplete!).to eq(false)
      expect(@task3.make_incomplete!).to eq(false)
    end

    it "Change the content of the task" do
      expect(@task1.update_content!("Ahora hago algo diferente")).to eq("Ahora hago algo diferente")
      expect(@task2.update_content!("Aqui tambien hago otra cosa")).to eq("Aqui tambien hago otra cosa")
      expect(@task3.update_content!("Pero aqui sigo descansando")).to eq("Pero aqui sigo descansando")
    end

    it "Add taks to the todo list" do
      expect(@Todo.add_task(@task1)).to eq([@task1])
      expect(@Todo.add_task(@task2)).to eq([@task1, @task2])
      expect(@Todo.add_task(@task3)).to eq([@task1, @task2, @task3])
    end

    #it "Delete taks from the todo list by its Id" do
    #  expect(@Todo.delete_task(2)).to eq([])
    #end

    it "Shows a taks from the todo list by its Id" do
      @Todo.add_task(@task1)
      @Todo.add_task(@task2)
      @Todo.add_task(@task3)

      expect(@Todo.find_task_by_id(@task3.id)).to eq(@task3.content)
    end

    it "Sorts the taks by the created_at field" do
      @Todo.add_task(@task1)
      @Todo.add_task(@task2)
      expect(@Todo.sort_by_created).to eq([@task1, @task2])
    end

    it "Creates a user with the todo object" do
      newuser = Todolist.new("Paco Pil")
      expect(newuser.user).to eq("Paco Pil")
    end

   it "Saves and loads the list of the tasks" do
      todo_list = Todolist.new("Josh")
      task = Task.new("Walk the dog")
      task2 = Task.new("Buy the milk")
      task3 = Task.new("Make my todo list into a web app")
      todo_list.add_task(task)
      todo_list.add_task(task2)
      todo_list.add_task(task3)
      todo_list.save
      todo_list = Todolist.new("Josh")
      todo_list.load_tasks
      expect(todo_list.load_tasks.length).to eq(3)
    end
  
  end

end