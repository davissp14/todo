module Todo
	class Validations
		class << self 
			def help_validations(args)
			  stock_validation(args.size, 0, 'todo help')
			end

			def lists_validations(args)
				stock_validation(args.size, 0, 'todo lists')
			end 

			def create_list_validations(args)
			  opts = stock_validation(args.size, 3, 'todo create_list list_name task_name description')
	      opts[:options] = {name: args[0], task: args[1], description: args[2]}
	      opts 
			end

			def delete_list_validations(args)
				opts = stock_validation(args.size, 1, "todo delete_list list_name")
				opts[:options] = {name: args[0]}
				opts 
			end

			def tasks_validations(args)
				opts = stock_validation(args.size, 1, "todo tasks list_name")
				opts[:options] = {name: args[0]}
				opts
			end

			def create_task_validations(args)
				opts = stock_validation(args.size, 3, "todo create_task list_name task_name description")
				opts[:options] = {name: args[0], task: args[1], description: args[2]}
		  end

		  def delete_task_validations(args)
		  	opts = stock_validation(args.size, 2, "todo delete_task list_name task_name")
		  	opts[:options] = {name: args[0], task: args[1]}
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