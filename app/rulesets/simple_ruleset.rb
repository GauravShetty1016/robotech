module Robotech
  module Ruleset
    class SimpleRuleset
      def initialize(boundaries:, options: {})
        @boundaries = boundaries
        @obstacles = options[:obstacles]
      end

      def valid_position?(position)
        return true if position.nil? || (position[:x] >= 0 && position[:x] < @boundaries[:width] &&
                                         position[:y] >= 0 && position[:y] < @boundaries[:height]) &&
                                        !is_blocked?(position)
        false
      end

      private

      def is_blocked?(position)
        blocked = false
        @obstacles.each do |ob|
          blocked = true if ob[:x] == position[:x] && ob[:y] == position[:y]
        end
        blocked
      end
    end
  end
end
