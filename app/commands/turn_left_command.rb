require_relative "command"

module Robotech
  module Commands
    class TurnLeftCommand < Command
      def perform
        return false if @action != valid_action || @position.nil? || @position[:facing_index].nil? || @orientations.nil?

        @position[:facing_index] = (@position[:facing_index] - 1) % @orientations.length
        @position
      end

      def valid_action
        @valid_action || "left"
      end
    end
  end
end
