module Assets
  class Frame

    def initialize
      @color = Canvas::Colors.red
      @walls = []

      build
    end

    def build
      @walls << Shapes::Segment.new do |seg|
        seg.origin = V.new(100, 100)
        seg.start = V.new(0, 0)
        seg.term = V.new($window_width - 200, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = V.new($window_width - 100, 100)
        seg.start = V.new(0, 0)
        seg.term = V.new(0, $window_height - 200)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = V.new($window_width - 100, $window_height - 100)
        seg.start = V.new(0, 0)
        seg.term = V.new(-($window_width - 200), 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = V.new(100, $window_height - 100)
        seg.start = V.new(0, 0)
        seg.term = V.new(0, -($window_height - 200))
        seg.color = @color
      end
    end

    def draw
      @walls.each { |wall| wall.draw }
    end

    def bodies
      @walls.map { |wall| wall.body }
    end
  end
end