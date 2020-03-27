require_relative "command"

module Robotech
  module Commands
    class ReportCommand < Command
      def perform
        return false unless is_valid_command?

        puts "#{@position[:x]},#{@position[:y]},#{@orientations[@position[:facing_index]].upcase}"
        @position
      end

      def valid_action
        @valid_action || "report"
      end

      private

      def is_valid_command?
        @action == valid_action && !@position.nil? && !@orientations.nil? && !@position[:facing_index].nil? && !@orientations[@position[:facing_index]].nil?
      end
    end
  end
end
