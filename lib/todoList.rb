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
    
    @tasks = file[@user]
  end

end