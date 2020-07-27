module Robotech
  module BoardGenerator
    class BaseBoardGenerator
      def initialize(board:, robot:, options: {})
        @board = board
        @robot = robot
        @options = options
      end

      def board
        @board.new(robot: @robot, options: @options)
      end
    end
  end
end
