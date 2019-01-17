module PickerShapes

  class Poly
    attr_reader :type

    def initialize(trans, spawn_pos, color)
      @type = "Polygon"
      @trans = trans
      @spawn_pos = spawn_pos

      @poly = [V.new(5, 0), V.new(30, 10), V.new(45, 30), V.new(50, 50), V.new(10, 40), V.new(0, 30)]
      @color = color
    end

    def draw
      verts = @trans.transform_all(@poly)
      Canvas::Pencil.poly(verts, VectMath.average(verts), @color.get, true, 1)
    end

    def spawn
      GJKShapes::Poly.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end