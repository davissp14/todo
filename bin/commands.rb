
require_relative '../todo'

module Todo
  class UnknownCommand < StandardError; end

  class Commands
  	extend Todo::Colors 
  	def self.parse(args)
      command = (args[0] && args[0].length < 3) ? convert_alias(args[0]) : args[0]

      raise UnknownCommand unless command && Operations.available_commands.include?(command.to_sym)
      response = Validations.send("#{command}_validations", args[1..-1])

      if response[:valid]
      	response.has_key?(:options) ?
  	  		Operations.new.send(command, response[:options]) :
  	  		Operations.new.send(command)
  	  else
  			colorize(:red){response[:message]}
      end
  	  rescue UnknownCommand
  	  	colorize(:red){"Run: `todo help` for a list of available options!"}
    end

    def self.convert_alias(cmd)
      alias_map = {
        h: "help",
        ct: "create_task",
        dt: "delete_task",
        sp: "set_priority",
        t: "tasks",
        l: "labels",
        cl: "create_label",
        dl: "delete_label"
      }
      alias_map[cmd.to_sym]
    end
  end
end

Todo::Commands.parse(ARGV) 
