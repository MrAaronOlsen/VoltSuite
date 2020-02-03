module GJKShapes
  class Background

    def initialize(pos, width, height, color)
      @pos, @width, @height, @color = pos, width, height, color
    end

    def draw
      Canvas::Pencil.rect2(@pos, @width, @height, @color.get, true, 0)
    end
  end
end