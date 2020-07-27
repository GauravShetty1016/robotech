require "readline"
require_relative "../board_generators/simple_board_generator"
require_relative "../parsers/simple_command_parser"
require_relative "../parsers/obstacle_file_parser"

module Robotech
  module GameMode
    class InteractiveMode
      def initialize(board_generator: Robotech::BoardGenerator::SimpleBoardGenerator,
                     command_parser: Robotech::Parser::SimpleCommandParser, obstacle_parser: Robotech::Parser::ObstacleFileParser,
                     options: {})
        @options = options
        @board_generator = board_generator
        @obstacles = obstacle_parser.parse(file: options[:obstacle_file]) if options[:obstacle_file]
        @board = @board_generator.new(options: { obstacles: @obstacles }).board
        @command_parser = command_parser
      end

      def start_game
        while command = Readline.readline("> ", true)
          break if command && command.downcase == "exit"
          next if command.nil? || command.length == 0

          run_command(command)
        end
      rescue Interrupt => e
        puts "Exiting..."
      end

      private

      def run_command(command)
        command = @command_parser.parse(command)
        return puts "Invalid Command" if command.nil?
        board.action command
      end

      def board
        return @board
      end
    end
  end
end
