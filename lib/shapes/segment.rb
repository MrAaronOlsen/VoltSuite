module Volt
  class Shape
    class Segment < Shape

      def initialize
        super(:line)

        yield self
      end

      def build(start, term)
        @verts = [start, term]
        @centroid = VectMath.average(@verts)
      end

      def get_support
        Contact::Support::Poly.new(@centroid, @verts)
      end
    end

    Seg = Segment
  end
end