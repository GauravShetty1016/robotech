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

        parser.on("-o", "-obstacle_list FILE NAME", "File listing the position of obstacles on the board") do |v|
          options[:obstacle_file] = v
        end
      end.parse!

      options[:interactive] = true if options.empty? || options[:file].nil?
      CLI.new(options).play
    end

    def initialize(options = {})
      @options = options
    end

    def play
      if !@options[:file].nil?
        mode = GameMode::FileInputMode.new(file: @options[:file], options: { obstacle_file: @options[:obstacle_file] })
      elsif @options[:interactive]
        mode = GameMode::InteractiveMode.new(options: { obstacle_file: @options[:obstacle_file] })
      end

      mode.start_game if mode
    end
  end
end
