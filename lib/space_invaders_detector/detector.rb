require 'space_invaders_detector/invader'

module SpaceInvadersDetector
  class Detector
    attr_reader :map, :sample
    attr_reader :map_y, :map_x

    def initialize(map, sample, map_y, map_x)
      @map = map
      @sample = sample
      @map_y = map_y
      @map_x = map_x
    end

    def map_presence
      calculate_stats unless @map_presence
      @map_presence
    end

    def probability
      calculate_stats unless @probability
      @probability
    end

    def top_y
      map_y
    end

    def bottom_y
      map_y + sample.height - 1
    end

    def left_x
      map_x
    end

    def right_x
      map_x + sample.width - 1
    end

    private

    def calculate_stats
      area = 0

      matches = 0
      (0...sample.height).each do |y|
        (0...sample.width).each do |x|
          my = map_y + y
          mx = map_x + x
          next unless map.has_cords?(my, mx)

          area += 1
          sample_val = sample[y, x]
          map_val = map[my, mx]
          matches += 1 if sample_val == map_val
        end
      end

      @map_presence = area / sample.area
      @probability = matches.to_f / area
    end
  end
end