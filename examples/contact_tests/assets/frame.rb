module Assets
  class Frame

    def initialize
      @color = Canvas::Colors.red
      @walls = []

      set_corners
      build
    end

    def set_corners
      margin = 250

      @trans = Transform.new_translate(V.new(margin, margin))

      @width = $window_width - margin * 2
      @height = $window_height - margin * 2

      @tl = @trans.transform(V.new(0, 0))
      @tr = @trans.transform(V.new(@width, 0))
      @br = @trans.transform(V.new(@width, @height))
      @bl = @trans.transform(V.new(0, @height))
    end

    def build
      @walls << Shapes::Segment.new do |seg|
        seg.pos = @tl
        seg.line = V.new(@width, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @tr
        seg.line = V.new(0, @height)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @br
        seg.line = V.new(-@width, 0)
        seg.color = @color
      end

      @walls << Shapes::Segment.new do |seg|
        seg.pos = @bl
        seg.line = V.new(0, -@height)
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