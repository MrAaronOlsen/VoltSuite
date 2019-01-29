module PickerShapes
  class Tri
    attr_reader :selection

    def initialize(trans, spawn_pos, color)
      @spawn_pos = spawn_pos
      @color = color

      @tri = trans.transform_all([V.new(-25, -25), V.new(25, -25), V.new(0, 25)])

      @selection = Selection.new(trans)
    end

    def draw
      Canvas::Pencil.tri(@tri, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Tri.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end