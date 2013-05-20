module Todo
  class Operations
    include Todo::Colors
  	def initialize; establish_connection; end 

  	def self.available_commands
      [:tasks, :create_task, :delete_task, :help]
  	end

    def tasks
      tasks = @redis.hkeys(namespace).zip(@redis.hvals(namespace))
      tasks.each do |task, description|
        colorize(:teal){"Task: #{task}"}
        colorize(:yellow){"**#{description}** \n"}
      end
      colorize(:yellow){"No active tasks present!"} if tasks.empty?
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
    	colorize(:green){Operations.available_commands.join(', ')}
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