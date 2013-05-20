module Todo
	module Colors
	  def red_output(output)
	     puts "\033[31m #{output} \033[0m"
	  end

	  def green_output(output)
			 puts "\033[32m #{output} \033[0m"
	  end

	  def yellow_output(output)
	 		puts "\033[33m #{output} \033[0m"
    end

    def teal_output(output)
      puts "\033[36m #{output} \033[0m"
    end
	end
end