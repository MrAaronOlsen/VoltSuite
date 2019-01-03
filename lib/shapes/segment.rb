module Volt
  class Shape
    class Segment < Shape

      def initialize
        super(:line)

        yield self
      end

      def build(v1, v2)
        @verts = [v1, v2]
        @centroid = VectMath.average(@verts)
      end
    end

    Seg = Segment
  end
end