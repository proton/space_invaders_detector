require 'space_invaders_detector/invader'
require 'space_invaders_detector/detector'

module SpaceInvadersDetector
  class Radar
    ACCURACY = 0.9
    MAP_PRESENCE = 0.7

    attr_reader :required_probability, :required_map_presence

    def initialize(accuracy: ACCURACY, map_presence: MAP_PRESENCE)
      @required_probability = accuracy
      @required_map_presence = map_presence
      reset_invader_samples
    end

    def load_map(map_image)
      @map = map_image
      reset_invaders
    end

    def reset_invader_samples
      @invader_samples = []
      reset_invaders
    end

    def add_invader_sample(sample_image)
      @invader_samples << sample_image
      reset_invaders
    end

    def invaders
      @invaders ||= scan_invaders
    end

    private

    def reset_invaders
      @invaders = nil
    end

    def scan_invaders
      @invaders = []

      @invader_samples.each do |sample|
        ys = (-sample.height + 1)...@map.height
        xs = (-sample.width + 1)...@map.width

        ys.each do |y|
          xs.each do |x|
            detector = SpaceInvadersDetector::Detector.new(@map, sample, y, x)
            next if detector.map_presence < required_map_presence
            next if detector.probability < required_probability

            @invaders << SpaceInvadersDetector::Invader.new(sample,
                                                            detector.top_y,
                                                            detector.bottom_y,
                                                            detector.left_x,
                                                            detector.right_x,
                                                            detector.probability,
                                                            detector.map_presence)
          end
        end
      end
      @invaders
    end
  end
end