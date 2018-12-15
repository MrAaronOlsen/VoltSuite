module Volt
  class Shape
    class Poly < Shape

      def initialize
        super(:poly)

        yield self
      end

      def set_verts(verts)
        @verts = verts
      end

      def get_support
        Support::Poly.new(@centroid, @verts)
      end
    end
  end
end