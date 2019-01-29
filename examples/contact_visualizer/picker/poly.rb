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
      verts = [V.new(5, 0), V.new(30, 10), V.new(45, 30), V.new(50, 50), V.new(10, 40), V.new(0, 30)]

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