module Todo
	class Validations
		class << self 
			def help_validations(args)
			  stock_validation(args.size, 0, 'todo help')
			end

			def tasks_validations(args)
				stock_validation(args.size, 0, "todo tasks")
			end

			def create_task_validations(args)
				opts = stock_validation(args.size, 2, "todo create_task task_name description")
				opts[:options] = {task: args[0], description: args[1]}
        opts
		  end

		  def delete_task_validations(args)
		  	opts = stock_validation(args.size, 1, "todo delete_task task_name")
		  	opts[:options] = {task: args[0]}
		  	opts
		  end 

		  def stock_validation(size, expected_size, cmd)
		  	opts = {}
				opts[:valid] = expected_size == size ? true : false
				opts[:message] = "Invalid Usage... Example: `#{cmd}`" unless opts[:valid]
				opts 
		  end

		  def method_missing(*args)
		  	red_output("No Validation Present!")
		  end
		end 
	end
end