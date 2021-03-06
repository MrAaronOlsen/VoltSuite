module Assets
  class Arena

    def initialize(pos)
      @pos = pos
      @color = Canvas::Colors.white
      @walls = []

      set_corners
      build
    end

    def set_corners
      @trans = Trans.new_translate(@pos)

      @width = $window_width - 300
      @height = $window_height - 100

      @tl = @trans.transform(V.new(0, 0))
      @tr = @trans.transform(V.new(@width, 0))
      @br = @trans.transform(V.new(@width, @height))
      @bl = @trans.transform(V.new(0, @height))
    end

    def build
      @walls << Shapes::Segment.new do |seg|
        seg.origin = @tl
        seg.line = V.new(@width, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = @tr
        seg.line = V.new(0, @height)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = @br
        seg.line = V.new(-@width, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.origin = @bl
        seg.line = V.new(0, -@height)
        seg.color = @color
      end

      @background = Background.new(@pos, @width, @height, Canvas::Color.new(80, 220, 220, 220))
    end

    def update(space)
    end

    def draw
      @background.draw
      @walls.each { |wall| wall.draw }
    end

    def bodies
      @walls.map { |wall| wall.body }
    end
  end
end