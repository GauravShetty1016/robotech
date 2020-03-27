require_relative "command"

module Robotech
  module Commands
    class ReportCommand < Command
      def perform
        return false if @action != "report"

        puts "#{@position[:x]},#{@position[:y]},#{@orientations[@position[:facing_index]].upcase}"
        @position
      end
    end
  end
end
