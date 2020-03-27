require_relative "base_board_generator"
require_relative "../components/simple_board"
require_relative "../components/simple_robot"

module Robotech
  module BoardGenerator
    class SimpleBoardGenerator < BaseBoardGenerator
      def initialize(board: Robotech::Component::SimpleBoard, robot: Robotech::Component::SimpleRobot, options: {})
        super(board: board, robot: robot, options: options)
      end
    end
  end
end
