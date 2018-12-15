class Shape
  class Tri < Shape

    def initialize
      super(:tri)

      yield self
    end

    def set_verts(v1, v2, v3)
      @verts << v1 << v2 << v3
    end

    def get_support
      Support::Poly.new(@centroid, @verts)
    end
  end
end