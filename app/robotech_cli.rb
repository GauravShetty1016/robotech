require "optparse"
require_relative "game_modes/file_input_mode"
require_relative "game_modes/interactive_mode"

module Robotech
  class CLI
    def self.start
      options = {}
      OptionParser.new do |parser|
        parser.on("-f", "--file FILE NAME", "The name of the input file.") do |v|
          options[:file] = v
        end

        parser.on("-i", "--interactive", "Interactive mode") do |v|
          options[:interactive] = v
        end
      end.parse!

      options[:interactive] = true if options.empty?
      CLI.new(options).play
    end

    def initialize(options = {})
      @options = options
    end

    def play
      if !@options[:file].nil?
        mode = GameMode::FileInputMode.new(file: @options[:file])
      elsif @options[:interactive]
        mode = GameMode::InteractiveMode.new
      end

      mode.start_game if mode
    end
  end
end
