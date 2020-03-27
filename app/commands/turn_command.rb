require_relative "command"

module Robotech
  module Commands
    class TurnCommand < Command
      def perform
        return false if !["left", "right"].include?(@action) || @position.nil?

        case @action
        when "left"
          @position[:facing_index] = (@position[:facing_index] - 1) % @orientations.length
        when "right"
          @position[:facing_index] = (@position[:facing_index] + 1) % @orientations.length
        end

        return @position
      end
    end
  end
end
