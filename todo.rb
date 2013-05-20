require 'redis'
require 'active_support'

require_relative 'lib/colors'
require_relative 'lib/validations'
require_relative 'lib/operations'

module Todo
	REDIS_HOST = "localhost"
	REDIS_PORT = 6379
	TODO_NAMESPACE = "todo_list"
end
