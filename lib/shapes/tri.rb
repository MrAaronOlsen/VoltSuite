module Volt
  class Shape
    class Triangle < Shape

      def initialize
        super(:tri)

        yield self
      end

      def build(v1, v2, v3)
        @verts = [v1, v2, v3]
        @centroid = VectMath.average(@verts)
      end

      def get_support
        Contact::Support::Poly.new(@centroid, @verts)
      end
    end

    Tri = Triangle
  end
end