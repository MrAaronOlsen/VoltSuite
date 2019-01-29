module Areas
  class Shape

    def initialize(offset)
      @origin = offset.transform(V.new)
      @width = 850
      @height = 1000

      @color = Canvas::Colors.white
    end

    def draw
      Canvas::Pencil.rect2(@origin, @width, @height, @color.get, false, 1)
    end
  end
end