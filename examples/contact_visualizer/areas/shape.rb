module Areas
  class Shape

    def initialize(offset)
      @origin = offset.transform(V.new)
      @width = 850
      @height = 1000

      @color = Canvas::Colors.white
      @background = GJKShapes::Background.new(@origin, @width, @height, Canvas::Color.new(80, 220, 220, 220))
    end

    def draw
      @background.draw
      Canvas::Pencil.rect2(@origin, @width, @height, @color.get, false, 1)
    end
  end
end