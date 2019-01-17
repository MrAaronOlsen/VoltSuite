module PickerShapes

  class Tri
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @type = "Triangle"
      @trans = trans
      @spawn_pos = spawn_pos

      @tri = [V.new(25, 0), V.new(50, 50), V.new(0, 50)]
      @color = color
    end

    def draw
      Canvas::Pencil.tri(@trans.transform_all(@tri), @color.get, true, 1)
    end

    def spawn
      GJKShapes::Tri.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end