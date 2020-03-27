module Robotech
  module Commands
    class PlaceCommand < Command
      def perform
        return false if @action != "place"
        return unless @ruleset.valid_position?({ x: @params[0].to_i, y: @params[1].to_i })

        @position = { x: @params[0].to_i, y: @params[1].to_i, facing_index: @orientations.index(@params[2]) }
        @position
      end
    end
  end
end
