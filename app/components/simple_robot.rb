require_relative "base_robot"
require_relative "../commands/move_command"
require_relative "../commands/place_command"
require_relative "../commands/report_command"
require_relative "../commands/turn_left_command"
require_relative "../commands/turn_right_command"

module Robotech
  module Component
    class SimpleRobot < BaseRobot
      def initialize(ruleset:, orientations: ["north", "east", "south", "west"],
                     commands: [Robotech::Commands::MoveCommand, Robotech::Commands::PlaceCommand,
                                Robotech::Commands::TurnLeftCommand, Robotech::Commands::TurnRightCommand,
                                Robotech::Commands::ReportCommand])
        @ruleset = ruleset
        @position = nil
        @commands = commands
        @orientations = orientations
      end

      def action(command)
        action, parameters = command
        is_valid_action = false

        @commands.each do |command_class|
          current_command = command_class.new(command: command, position: @position, orientations: @orientations, ruleset: @ruleset)
          if current_command.perform
            @position = current_command.position
            is_valid_action = true
            break
          end
        end

        return is_valid_action
      rescue ArgumentError => e
        # Do nothing
      end
    end
  end
end
