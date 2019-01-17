module PickerShapes

  class Circle
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @type = "Circle"
      @trans = trans
      @spawn_pos = spawn_pos

      @center = V.new(0, 0)
      @radius = 30

      @color = color
    end

    def draw
      Canvas::Pencil.circle(@trans.transform(@center), @radius, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Circle.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end