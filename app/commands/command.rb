module Robotech
  module Commands
    class Command
      attr_reader :position

      def initialize(command:, position:, orientations:, ruleset:, options: {})
        raise ArgumentError, "Command cannot be empty" if command.nil?
        raise ArgumentError, "Position cannot be empty" if position.nil?
        raise ArgumentError, "Invalid Position format" unless position.has_key?(:x) && position.has_key?(:y) && position.has_key?(:facing_index)
        @action, @params = command
        @position = position
        @orientations = orientations
        @ruleset = ruleset
        @options = options
      end

      def perform
        raise NotImplementedError
      end
    end
  end
end
