require 'rspec'

class Todolist

end

class Task
	attr_reader :content, :id, :done
    @@current_id = 1
    def initialize(content)
        @content = content
        @id = @@current_id
        @@current_id += 1
        @done = false
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

end


describe Todolist do 

before :each do
#	@Todo = Task.new
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

  end

end