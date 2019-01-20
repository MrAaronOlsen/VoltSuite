module Volt
  module Contact
    module Support
      class Poly
        attr_reader :center, :points

        def initialize(center, points)
          @center, @points = center, points
        end

        def transform(trans)
          @center = trans.transform(@center)
          @points = trans.transform_verts(@points)
        end

        def get_support(axis)
          VectMath.farthest_point_along_axis(@points, axis).point
        end

        def get_feature(axis)
          # First get the farthest point along the given axis
          farthest_point = VectMath.farthest_point_along_axis(@points, axis)

          point = farthest_point.point
          index = farthest_point.index

          # Find the next and previous point in the points array
          next_point = index == @points.size - 1 ? @points[0] : @points[index + 1]
          previous_point = index == 0 ? @points[points.size - 1] : @points[index - 1]

          # Build two edges from the farthest point to the points on each side of it
          edge1 = Edge.new(previous_point, point)
          edge2 = Edge.new(point, next_point)

          # Return edge that is most perpendicular to axis
          edge1.normal.dot(axis) < edge2.normal.dot(axis) ? edge1 : edge2
        end
      end
    end
  end
end