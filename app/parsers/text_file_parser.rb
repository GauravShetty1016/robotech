module Robotech
  module Parser
    class TextFileParser
      def self.parse(file:, options: {})
        raise ArgumentError, "Invalid File Name" if file.nil?
        # Using block yield so that we read files one line at a time. This ensures we can handle very large files
        # without overloading ruby memory.
        File.foreach(file) do |command|
          command = command.chomp
          yield command if block_given?
        end
      rescue ArgumentError => e
        puts e.message
      rescue Errno::ENOENT => e
        puts e.message
      end
    end
  end
end
