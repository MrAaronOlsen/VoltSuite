module PickerShapes
  class Line
    attr_reader :type

    def initialize(trans, spawn_pos)
      @type = "Line"
      @trans = trans
      @spawn_pos = spawn_pos

      @line = @trans.transform_all([V.new(0, 0), V.new(50, 50)])
      @color = Canvas::Colors.yellow
    end

    def draw
      Canvas::Pencil.line(@line, @color.get, 1)
    end

    def spawn
      GJKShapes::Line.new(@spawn_pos)
    end
  end
end