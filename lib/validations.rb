module Todo
	class Validations
		class << self 
			def help_validations(args)
			  stock_validation(args.size, 0, 'todo help')
			end

      def labels_validations(args)
        stock_validation(args.size, 0, "todo labels")
      end

      def create_label_validations(args)
        opts = stock_validation(args.size, 1, "todo create_label label_name")
        opts[:options] = {label: args[0]}
        opts
      end

      def delete_label_validations(args)
        opts = stock_validation(args.size, 1, "todo delete_label label_name")
        opts[:options] = {label: args[0]}
        opts
      end

			def tasks_validations(args)
				stock_validation(args.size, 0, "todo tasks")
			end

			def create_task_validations(args)
				opts = stock_validation(args.size, [2,3], "todo create_task task_name description priority (optional)")
				opts[:options] = {task: args[0], description: args[1]}
        opts[:options].merge!(priority: args[2]) if args[2]

        # Validate Priority Value if present
        if args[2] && !args[2].match(/\d{1,}/)
          opts[:valid] = false
          opts[:message] = "Priority must be an Integer."
        end
        opts
		  end

		  def delete_task_validations(args)
		  	opts = stock_validation(args.size, 1, "todo delete_task task_name")
		  	opts[:options] = {task: args[0]}
		  	opts
		  end

		  def set_priority_validations(args)
		  	opts = stock_validation(args.size, 2, "todo set_priority task_name priority")
		  	opts[:options] = {task: args[0], priority: args[1]}
		  	opts
		  end 

		  def stock_validation(size, expected_size, cmd)
		  	opts = {}
        expected_size.is_a?(Array) ?
          (opts[:valid] = size.between?(expected_size[0], expected_size[1]) ? true : false) :
          (opts[:valid] = expected_size == size ? true : false)

				opts[:message] = "Invalid Usage... Example: `#{cmd}`" unless opts[:valid]
				opts 
		  end

		  def method_missing(*args)
		  	colorize(:red){"No Validation Present!"}
		  end
		end 
	end
end