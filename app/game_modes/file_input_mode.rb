require_relative "../parsers/text_file_parser"
require_relative "../validators/command_validator"
require_relative "../board_generators/simple_board_generator"
require_relative "../parsers/simple_command_parser"

module Robotech
  module GameMode
    class FileInputMode
      def initialize(file:, validator: Robotech::Validator::CommandValidator, parser: Robotech::Parser::TextFileParser,
                     board_generator: Robotech::BoardGenerator::SimpleBoardGenerator, command_parser: Robotech::Parser::SimpleCommandParser, options: {})
        @file = file
        @options = options
        @validator = validator
        @parser = parser
        @board_generator = board_generator
        @board = @board_generator.new.board
        @command_parser = command_parser
      end

      def start_game
        commands do |command|
          command = @command_parser.parse(command)
          next if command.nil? || !@validator.validate(command)
          board.action command
        end
      end

      private

      def board
        return @board
      end

      def commands(&block)
        @parser.parse(file: @file, &block)
      end
    end
  end
end
