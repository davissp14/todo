module Todo
  class Operations
    include Todo::Colors
  	def initialize; establish_connection; end 

  	def self.available_commands
  		[:lists, :create_list, :delete_list, :tasks, :create_task, :delete_task, :help]
  	end

    def lists
      lists = @redis.keys("#{TODO_NAMESPACE}*").map{|k| k.split(':').last} 
      lists.size > 0 ? green_output(lists) : yellow_output("No active lists present...")
    end 

    def create_list(opts)
    	@redis.hset(prefix(opts[:name]), opts[:task], opts[:description])
      tasks(name: opts[:name])
    end

    def delete_list(opts)
      @redis.del(prefix(opts[:name]))
      lists 
    end

    def tasks(opts={})
    	if opts.empty?
    		if lists.is_a?(Array)
          # Display All Tasks...
    		  
    		end
    	else 
    		labels = @redis.hkeys(prefix(opts[:name]))
    		tasks = labels.zip(@redis.hvals(prefix(opts[:name])))
      	yellow_output(tasks.map{|k| "#{k} \n"})
      end
    end

    def create_task(opts)
    	@redis.hmset(prefix(opts[:name]), opts[:task], opts[:description])
    	tasks(name)
    end

    def delete_task(opts)
      @redis.hdel(prefix(opts[:name]), opts[:task])
      tasks(name: opts[:name])
    end

    def help
    	green_output(Operations.available_commands.join(', '))
    end

    private

    def establish_connection
      @redis ||= Redis.new(host: REDIS_HOST, port: REDIS_PORT)
    end

  	def prefix(name)
      "#{TODO_NAMESPACE}:#{name}"
    end
  end
end