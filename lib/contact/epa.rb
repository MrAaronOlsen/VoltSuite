module Volt
  module Contact
    class EPA
      attr_reader :max_iterations, :closest_edge, :depth, :normal

      EPSILON ||= Math.sqrt(VoltMath::Epsilon.e)

      def initialize
        @max_interations = 100
      end

      def get_normal
        @normal
      end

      def get_depth
        @depth
      end

      def get_closest_edge
        @closest_edge
      end

      def solve(minkowski, simplex)
        winding = simplex.get_winding

        polytope = Polytope.new
        polytope.add_all(simplex.build_edges)

        @max_interations.times do |i|
          edge = polytope.see_closest_edge
          point = minkowski.get_support(edge.normal * winding)

          projection = point.dot(edge.normal * winding)
          depth = projection - edge.distance

          if depth <= EPSILON
            @closest_edge = edge
            @depth = projection
            @normal = edge.normal * winding

            return true
          else
            polytope.expand(point)
          end
        end

        @closest_edge = edge
        @depth = projection
        @normal = edge.normal * winding
      end
    end
  end
end