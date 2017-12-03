require 'space_invaders_detector/invader'

module SpaceInvadersDetector
  class Radar
    ACCURACY = 0.95

    attr_reader :accuracy

    def initialize(accuracy: ACCURACY)
      @accuracy = accuracy
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
        ys = 0..(@map.height - sample.height)
        xs = 0..(@map.width - sample.width)

        ys.each do |y|
          xs.each do |x|
            invader = test_cords_for_invader(sample, y, x)
            @invaders << invader if invader
          end
        end
      end
      @invaders
    end

    def test_cords_for_invader(sample, map_y, map_x)
      matches = 0
      (0...sample.height).each do |y|
        (0...sample.width).each do |x|
          sample_val = sample[y, x]
          map_val = @map[map_y + y, map_x + x]
          matches += 1 if sample_val == map_val
        end
      end

      probability = matches.to_f / sample.area
      return if probability < accuracy

      SpaceInvadersDetector::Invader.new(sample,
                                         map_y,
                                         map_y + sample.height - 1,
                                         map_x,
                                         map_x + sample.width - 1)
    end
  end
end