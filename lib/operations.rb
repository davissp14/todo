module Todo
  class Operations
    include Todo::Colors
  	def initialize; establish_connection; end 

  	def self.available_commands
      [:tasks, :create_task, :delete_task, :labels, :create_label, :delete_label, :set_priority, :help]
  	end

    def tasks
      priorities = @redis.zrange(priority_namespace, 0, -1)
      vals = priorities.map{|priority| @redis.hmget(namespace, priority) }
      tasks = priorities.zip(vals)

      tasks.each do |task, description|
        priority = @redis.zscore(priority_namespace, task) || "N/A"
        colorize(:yellow){"Task: #{task} - Priority: #{priority}"}
        colorize(:teal){"**#{description.join('')}** \n"}
      end
      colorize(:yellow){"No active tasks present!"} if tasks.empty?
    end

    def create_task(opts)
    	@redis.hmset(namespace, opts[:task], opts[:description])
      @redis.zadd(priority_namespace, (opts[:priority] || 10), opts[:task])
    	tasks
    end

    def delete_task(opts)
      @redis.hdel(namespace, opts[:task])
      @redis.zrem(priority_namespace, opts[:task])
      tasks
    end

    def labels
      labels = @redis.smembers(label_namespace)
      labels.empty? ?
        colorize(:red){"No labels present..."} :
        colorize(:green){labels.join(', ')}
    end

    def create_label(opts)
      @redis.sadd(label_namespace, opts[:label])
      labels
    end

    def delete_label(opts)
      @redis.srem(label_namespace, opts[:label])
      labels
    end


    def set_priority(opts)
      @redis.zadd(priority_namespace, opts[:priority], opts[:task])
      tasks
    end
    

    def help
    	colorize(:green){Operations.available_commands.join(', ')}
    end

    private

    def namespace
      TODO_NAMESPACE
    end

    def priority_namespace
      "#{namespace}:priority"
    end

    def label_namespace
      "#{namespace}:label"
    end

    def establish_connection
      @redis ||= Redis.new(host: REDIS_HOST, port: REDIS_PORT)
    end
  end
end