module Todo
	module Colors
    def colorize(color, &block)
      case color
        when :green
          puts "\033[32m #{yield} \033[0m"
        when :red
          puts "\033[31m #{yield} \033[0m"
        when :yellow
          puts "\033[33m #{yield} \033[0m"
        when :teal
          puts "\033[36m #{yield} \033[0m"
        else
          puts yield
      end
    end
	end
end