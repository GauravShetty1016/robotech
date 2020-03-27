require_relative "command"

module Robotech
  module Commands
    class TurnCommand < Command
      def perform
        return false if !valid_action.include?(@action) || @position.nil?

        case @action
        when "left"
          @position[:facing_index] = (@position[:facing_index] - 1) % @orientations.length
        when "right"
          @position[:facing_index] = (@position[:facing_index] + 1) % @orientations.length
        end

        return @position
      end

      def valid_action
        return ["left", "right"] if @valid_action.nil? || !@valid_action.kind_of?(Array)
        @valid_action
      end
    end
  end
end
