module PickerShapes
  class Poly
    attr_reader :selection

    def initialize(trans, spawn_pos, color)
      @spawn_pos = spawn_pos
      @color = color

      @poly = trans.transform_all(centered_poly)
      @center = trans.transform(@center)

      @selection = Selection.new(trans)
    end

    def centered_poly
      verts = GJKShapes::Poly.make_poly(30, 8)

      @center = VectMath.area_average(verts)
      verts.map { |vert| @center - vert }
    end

    def draw
      Canvas::Pencil.poly(@poly, @center, @color.get, true, 1)
    end

    def spawn
      GJKShapes::Poly.new(@spawn_pos).tap do |shape|
        shape.color = @color
      end
    end
  end
end