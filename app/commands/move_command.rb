module Robotech
  module Commands
    class MoveCommand < Command
      def perform
        return false if @action != "move"

        next_position = position_on_move
        return unless @ruleset.valid_position?(next_position)
        @position = next_position
        @position
      end

      private

      def position_on_move
        next_position = @position.clone
        case @position[:facing_index]
        when 0
          next_position[:y] += 1
        when 1
          next_position[:x] += 1
        when 2
          next_position[:y] -= 1
        when 3
          next_position[:x] -= 1
        end

        next_position
      end
    end
  end
end
