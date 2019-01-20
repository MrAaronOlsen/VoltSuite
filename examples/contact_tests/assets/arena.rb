module Assets
  class Arena

    def initialize(pos)
      @pos = pos
      @color = Canvas::Colors.green
      @walls = []

      set_corners
      build
    end

    def set_corners
      @trans = Trans.new_translate(@pos)

      @width = $window_width - 400
      @height = $window_height - 200

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