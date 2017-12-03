module SpaceInvadersDetector
  class Radar
    ACCURACY = 0.95

    def initialize(accuracy: ACCURACY)
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
    end
  end
end