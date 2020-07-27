module Robotech
  module Parser
    class ObstacleFileParser
      def self.parse(file:, options: {})
        raise ArgumentError, "Invalid File Name" if file.nil?
        # Using block yield so that we read files one line at a time. This ensures we can handle very large files
        # without overloading ruby memory.
        obstacles = []
        File.foreach(file) do |obstacle|
          obstacle = obstacle.chomp.split(",")
          next unless Float(obstacle[0]) && Float(obstacle[1]) rescue true
          obstacles.push({ x: obstacle[0].to_i, y: obstacle[1].to_i })
        end
        return obstacles
      rescue ArgumentError => e
        puts e.message
      rescue Errno::ENOENT => e
        puts e.message
      end
    end
  end
end
