module Assets
  class Frame

    def initialize
      @color = Canvas::Colors.red
      @walls = []

      set_corners
      build
    end

    def set_corners
      @center = V.new($window_width / 2, $window_height / 2)

      @tl = @center + V.new(-500, -500)
      @tr = @center + V.new(500, -500)
      @br = @center + V.new(500, 500)
      @bl = @center + V.new(-500, 500)
    end

    def build
      @walls << Shapes::Segment.new do |seg|
        seg.pos = @tl
        seg.line = V.new(1000, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @tr
        seg.line = V.new(0, 1000)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @br
        seg.line = V.new(-1000, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @bl
        seg.line = V.new(0, -1000)
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