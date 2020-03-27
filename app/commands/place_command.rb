require_relative "command"

module Robotech
  module Commands
    class PlaceCommand < Command
      def perform
        return false unless is_valid_command?
        return unless @ruleset.valid_position?({ x: @params[0].to_i, y: @params[1].to_i })

        @position = { x: @params[0].to_i, y: @params[1].to_i, facing_index: @orientations.index(@params[2]) }
        @position
      end

      private

      def is_valid_command?
        return false if @action != "place" || @params.nil? || @params.length == 0

        x, y, facing = @params

        valid_coordinates = true if Float(x) && Float(y) rescue false
        return false if !valid_coordinates || !["north", "south", "east", "west"].include?(facing)
        true
      end
    end
  end
end
