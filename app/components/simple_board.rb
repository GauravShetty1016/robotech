require_relative "simple_robot"
require_relative "base_board"
require_relative "../rulesets/simple_ruleset"

module Robotech
  module Component
    class SimpleBoard < BaseBoard
      def initialize(robot: SimpleRobot, ruleset: Robotech::Ruleset::SimpleRuleset, options: {})
        @options = options
        @width = @options[:width] || 5
        @height = @options[:height] || 5
        @ruleset = ruleset.new(boundaries: { width: @width, height: @height }, options: options)
        @robot = robot.new(ruleset: @ruleset)
      end
    end
  end
end
