module Robotech
  module Parser
    class SimpleCommandParser
      def self.parse(command)
        return nil if command.nil? || command.length == 0
        # Convert all commands to the same case, remove extra spaces at the ends and in between params.
        command = command.chomp.downcase.gsub(/ +/, " ").gsub(", ", ",")
        action, parameters = command.split(" ")

        return [action] if parameters.nil? || parameters.length == 0
        [action, parameters.split(",").map(&:chomp)]
      end
    end
  end
end
