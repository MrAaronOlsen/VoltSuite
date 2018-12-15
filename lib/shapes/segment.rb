module Volt
  class Shape
    class Segment < Shape

      def initialize
        super(:line)

        yield self
      end

      def set_verts(v1, v2)
        @verts = [v1, v2]
      end

      def get_support
        Support::Poly.new(@centroid, @verts)
      end
    end

    Seg = Segment
  end
end