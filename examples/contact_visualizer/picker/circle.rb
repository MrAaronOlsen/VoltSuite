module PickerShapes

  class Circle
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @spawn_pos = spawn_pos
      @color = color

      @center = trans.transform(V.new())
      @radius = 30
    end

    def draw
      Canvas::Pencil.circle(@center, @radius, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Circle.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end