module SpaceInvadersDetector
  class Image
    attr_reader :width, :height

    SPACE_SYMBOL = '-'
    OBJECT_SYMBOL = 'o'
    SYMBOL_VALUES = { SPACE_SYMBOL => 0, OBJECT_SYMBOL => 1 }

    def initialize(init_data = nil)
      case init_data
      when Array
        load_image init_data
      when String
        load_image_file init_data
      when NilClass
      else
        raise 'unknown initialization data'
      end
    end

    def load_image(arr2d)
      @height = arr2d.size
      raise 'image is empty' if height.zero?
      @width = arr2d[0].size
      raise 'image is empty' if width.zero?
      raise 'image should be array of strings' unless arr2d[0].is_a?(String)

      @image = []
      arr2d.each do |row|
        raise 'row length is incorrect' unless row.size == width
        @image << row.chars.map do |char|
          raise 'unknown symbol' unless SYMBOL_VALUES.include? char
          SYMBOL_VALUES[char]
        end
      end
    end

    def load_image_file(file_path)
      arr2d = File.open(file_path).readlines.map(&:strip)
      load_image(arr2d)
    end

    def area
      width * height
    end

    def has_cords?(y, x)
      (0...height).cover?(y) && (0...width).cover?(x)
    end

    def [](y, x)
      raise 'cords are incorrect' unless has_cords?(y, x)
      @image[y][x]
    end
  end
end