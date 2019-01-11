module Volt
  class Shape
    class Polygon < Shape

      def initialize
        super(:poly)

        yield self
      end

      def build(verts)
        @verts = verts
        @centroid = VectMath.area_average(@verts)
      end

      def get_support
        Support::Poly.new(@centroid, @verts)
      end
    end

    Poly = Polygon
  end
end