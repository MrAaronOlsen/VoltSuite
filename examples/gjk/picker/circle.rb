module PickerShapes

  class Circle
    attr_reader :type

    def initialize(trans, spawn_pos)
      @type = "Circle"
      @trans = trans
      @spawn_pos = spawn_pos

      @center = V.new(0, 0)
      @radius = 25

      @color = Canvas::Colors.orange
    end

    def draw
      Canvas::Pencil.circle(@trans.transform(@center), @radius, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Circle.new(@spawn_pos, 100)
    end
  end
end