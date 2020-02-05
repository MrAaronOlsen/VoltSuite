module Areas
  class Shape
    attr_reader :origin, :width, :height
    attr_reader :spawn_lr, :spawn_ul

    def initialize(offset)
      @origin = offset.transform(V.new)
      @width = 400
      @height = 400

      spawn_offset = 150

      @spawn_ul = @origin + V.new(spawn_offset, spawn_offset)
      @spawn_lr = @origin + V.new(@width - spawn_offset, @height - spawn_offset)

      @color = Canvas::Colors.white
      @background = GJKShapes::Background.new(@origin, @width, @height, Canvas::Color.new(80, 220, 220, 220))
    end

    def draw
      @background.draw
      Canvas::Pencil.rect2(@origin, @width, @height, @color.get, false, 1)
    end
  end
end