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
    end

    Seg = Segment
  end
end