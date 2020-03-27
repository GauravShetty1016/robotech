module Robotech
  module Commands
    class ReportCommand < Command
      def perform
        return false if @action != "report"

        puts "#{@current_position[:x]},#{@current_position[:y]},#{ORIENTATION[@orientation_index].upcase}"
        @position
      end
    end
  end
end
