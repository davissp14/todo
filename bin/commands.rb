
require_relative '../todo'
module Todo
  class Commands
  	extend Todo::Colors 
  	def self.parse(args)
      raise UnknownCommand unless args[0] && Operations.available_commands.include?(args[0].to_sym)  
      response = Validations.send("#{args[0]}_validations", args[1..-1])  

      if response[:valid]
      	response.has_key?(:options) ?
  	  		Operations.new.send(args[0], response[:options]) :
  	  		Operations.new.send(args[0])
  	  else
  			red_output(response[:message])
      end
  	  rescue UnknownCommand
  	  	red_output("Run: `todo help` for a list of available options!")
  	end
  end
end

Todo::Commands.parse(ARGV) 