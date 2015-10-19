require 'rspec'

class Todolist

end

class Task
	attr_reader :content, :id
    @@current_id = 1
    def initialize(content)
        @content = content
        @id = @@current_id
        @@current_id += 1
        @id
    end
end


describe Todolist do 

#before :each do
#	@Todo = Task.new
#end

  describe "#CreatingTask" do
    it "Creates a new task and gives back an unique Id" do
      expect(Task.new("alguna cosa tendre que hacer").id).to eq(1)
      expect(Task.new("luego hare algo mas").id).to eq(2)
      expect(Task.new("y luego toca descansar").id).to eq(3)
    end

  end

end