module Todo
  class Operations
    include Todo::Colors
  	def initialize; establish_connection; end 

  	def self.available_commands
      [:tasks, :create_task, :delete_task, :help]
  	end

    def tasks
      keys = @redis.hkeys(namespace)
      descriptions = @redis.hvals(namespace)
      tasks = keys.zip(descriptions)
      yellow_output(tasks.empty? ? "No active tasks present!" : tasks)
    end

    def create_task(opts)
    	@redis.hmset(namespace, opts[:task], opts[:description])
    	tasks
    end

    def delete_task(opts)
      @redis.hdel(namespace, opts[:task])
      tasks
    end

    def help
    	green_output(Operations.available_commands.join(', '))
    end

    private

    def namespace
      TODO_NAMESPACE
    end
    def establish_connection
      @redis ||= Redis.new(host: REDIS_HOST, port: REDIS_PORT)
    end
  end
end