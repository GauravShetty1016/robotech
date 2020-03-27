require_relative "base_robot"
require_relative "../commands/move_command"
require_relative "../commands/place_command"
require_relative "../commands/report_command"
require_relative "../commands/turn_command"

module Robotech
  module Component
    class SimpleRobot < BaseRobot
      def initialize(ruleset:, orientations: ["north", "east", "south", "west"],
                     commands: [Robotech::Commands::MoveCommand, Robotech::Commands::PlaceCommand,
                                Robotech::Commands::TurnCommand, Robotech::Commands::ReportCommand])
        @ruleset = ruleset
        @position = nil
        @orientation_index = nil
        @commands = commands
        @orientations = orientations
      end

      def action(command)
        action, parameters = command
        return if (@position.nil? && action != "place")

        @commands.each do |command_class|
          current_command = command_class.new(command: command, position: @position, orientations: @orientations, ruleset: @ruleset)
          if current_command.perform
            @position = current_command.position
            break
          end
        end
      rescue ArgumentError => e
        # Do nothing
      end
    end
  end
end
