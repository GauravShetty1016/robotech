module Robotech
  module Commands
    class Command
      attr_reader :position

      def initialize(command:, position:, orientations:, ruleset:, options: {})
        raise ArgumentError, "Command cannot be empty" if command.nil?
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
