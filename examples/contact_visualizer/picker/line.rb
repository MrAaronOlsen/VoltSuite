module PickerShapes
  class Line
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @spawn_pos = spawn_pos

      @line = trans.transform_all([V.new(-25, -25), V.new(25, 25)])
      @color = color
    end

    def draw
      Canvas::Pencil.line(@line, @color.get, 1)
    end

    def spawn
      GJKShapes::Line.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end