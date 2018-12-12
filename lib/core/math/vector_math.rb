class VectorMath
  PointAlongAxis = Struct.new(:point, :position, :index)

  class << self

    # Projects vect2 onto vect1 and returns the projection as a vector
    def projection(vect1, vect2)
      d = vect2.dot(vect2)

      if 0 < d
        dp = vect1.dot(vect2)
        vect2 * (dp / d)
      else
        vect2
      end
    end

    # Checks if a point lies ahead of the origin along an axis. The check is done using the direction of the axis,
    # so if a point lies before the origin in the direction of the axis we'll get a negitive number.
    def before_origin(point, axis)
      point.dot(axis) <= 0
    end

    # Returns the position of a point along an axis in the direction of the axis from the origin. The position
    # is relative to the axis leangth, which means this does not give an axtual distance but the relationship
    # of the point on the axis.
    def position_along_axis(axis, point)
      axis.dot(point)
    end

    # Compared to the ref returns -1 if a is to the right of b, 1 if a to the left of b, and 0 if points are on the same axis
    def determinant(ref, a, b)
      (a.y - ref.y) * (b.x - a.x) - (b.y - a.y) * (a.x - ref.x) <=> 0
    end

    # Returns average of all points, which is conveniently the center point of a convex polygon
    def average(points)
      points.reduce(V.new) { |sum, point| sum += point } / points.size
    end

    # Returns the normal of a to b most in the direction of c.
    def normal_towards(a, b, c)
      ac = a.dot(c)
      bc = b.dot(c)

      x = b.x * ac - a.x * bc
      y = b.y * ac - a.y * bc

      V.new(x, y)
    end

    # Returns the distance of a point to the given line
    def distance_of_point_to_line(point, line, point_on_line)
      (point - point_on_line).dot((line).normal_unit).abs
    end

    # Returns the actual distance from self to another vector point
    def distance_between(point1, point2)
      (point1 - point2).mag
    end

    # Given a set of points returns the point farthest along an exis from the origin along with it's index in the array
    def farthest_point_along_axis(points, axis)
      PointAlongAxis.new(nil, nil, nil).tap do |farthest|
        points.each_with_index do |point, i|
          this_position = position_along_axis(axis, point)

          if farthest.position.nil? || this_position > farthest.position
            farthest.point = point
            farthest.index = i
            farthest.position = this_position
          end
        end
      end
    end
  end
end

VectMath = VectorMath
VMath = VectorMath