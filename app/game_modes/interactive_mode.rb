require "readline"
require_relative "../validators/command_validator"
require_relative "../board_generators/simple_board_generator"
require_relative "../parsers/simple_command_parser"

module Robotech
  module GameMode
    class InteractiveMode
      def initialize(validator: Robotech::Validator::CommandValidator, board_generator: Robotech::BoardGenerator::SimpleBoardGenerator,
                     command_parser: Robotech::Parser::SimpleCommandParser, options: {})
        @options = options
        @validator = validator
        @board_generator = board_generator
        @board = @board_generator.new.board
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
        return puts "Invalid Command" if command.nil? || !@validator.validate(command)
        board.action command
      end

      def board
        return @board
      end
    end
  end
end
