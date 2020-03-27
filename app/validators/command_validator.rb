module Robotech
  module Validator
    class CommandValidator
      def self.validate(command)
        return false if command.nil? || command.length == 0
        action, parameters = command

        return true if ["move", "left", "right", "report"].include?(action)
        return false if action != "place" || parameters.nil? || parameters.length == 0

        x, y, facing = parameters

        valid_coordinates = true if Float(x) && Float(y) rescue false
        return false if !valid_coordinates || !["north", "south", "east", "west"].include?(facing)
        true
      end
    end
  end
end
