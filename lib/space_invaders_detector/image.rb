module SpaceInvadersDetector
  class Image
    attr_reader :width, :height

    SPACE_SYMBOL = '-'
    OBJECT_SYMBOL = 'o'
    SYMBOL_VALUES = { SPACE_SYMBOL => 0, OBJECT_SYMBOL => 1 }

    def initialize(arr2d = nil)
      load_image(arr2d) if arr2d
    end

    def load_image(arr2d)
      @height = arr2d.size
      raise 'load error: image is empty' if height.zero?
      @width = arr2d[0].size
      raise 'load error: image is empty' if width.zero?

      @image = []
      arr2d.each do |row|
        raise 'row length is incorrect' unless row.size == width
        @image << row.chars.map do |char|
          raise 'unknown symbol' unless SYMBOL_VALUES.include? char
          SYMBOL_VALUES[char]
        end
      end
    end

    def load_image_file(filepath)
      arr2d = File.open(filepath).readlines.map(&:strip)
      load_image(arr2d)
    end

    def [](y, x)
      raise 'y is incorrect' unless (0...height).cover? y
      raise 'x is incorrect' unless (0...width).cover? x

      @image[y][x]
    end
  end
end