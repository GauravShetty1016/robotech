require_relative "command"

module Robotech
  module Commands
    class ReportCommand < Command
      def perform
        return false if @action != valid_action || @position.nil?

        puts "#{@position[:x]},#{@position[:y]},#{@orientations[@position[:facing_index]].upcase}"
        @position
      end

      def valid_action
        @valid_action || "report"
      end
    end
  end
end
