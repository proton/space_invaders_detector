module SpaceInvadersDetector
  class Invader
    attr_reader :sample
    attr_reader :top_y, :bottom_y, :left_x, :right_x
    attr_reader :probability

    def initialize(sample, top_y, bottom_y, left_x, right_x, probability)
      @sample = sample
      @top_y = top_y
      @bottom_y = bottom_y
      @left_x = left_x
      @right_x = right_x
      @probability = probability
    end
  end
end