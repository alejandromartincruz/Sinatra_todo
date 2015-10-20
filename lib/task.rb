require 'rspec'
require 'pry'
require 'yaml/store'

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