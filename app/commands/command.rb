module Robotech
  module Commands
    class Command
      attr_reader :position

      def initialize(command:, position:, ruleset:, orientations: [], valid_action: nil, options: {})
        raise ArgumentError, "Command cannot be empty" if command.nil?
        @action, @params = command
        @position = position
        @orientations = orientations
        @ruleset = ruleset
        @options = options
        @valid_action = valid_action
      end

      def perform
        raise NotImplementedError
      end

      def valid_action=(action)
        @valid_action = action
      end
    end
  end
end
