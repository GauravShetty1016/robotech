module Robotech
  module Component
    class BaseBoard
      def action(command)
        @robot.action(command)
      end
    end
  end
end
