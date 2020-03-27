module Robotech
  module Ruleset
    class SimpleRuleset
      def initialize(boundaries:, options: {})
        @boundaries = boundaries
      end

      def valid_position?(position)
        return true if position.nil? || (position[:x] >= 0 && position[:x] < @boundaries[:width] && position[:y] >= 0 && position[:y] < @boundaries[:height])
        false
      end
    end
  end
end
