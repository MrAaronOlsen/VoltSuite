module Volt
  class VectorMath

    class << self
      include Volt::Structs

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

      def area_average(points)
        size = points.size
        return points[0] if size == 1
        return average(points) if size == 2

        area = 0.0;

        ac = average(points)
        center = V.new

    		points.each_with_index do |point, i|
    			p1 = points[i] - ac
    			p2 = points[(i + 1) % size] - ac

    			d = p1.cross(p2)
    			triangleArea = 0.5 * d

    			area += triangleArea;

    			center.add(p1.add(p2).mult(1.0/3.0).mult(triangleArea))
        end

    		return points[0] if area.abs <= VoltMath::Epsilon.e

    		center.mult(1.0 / area)
    		center.add(ac)
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

      # Returns true if point is inside of poly, false if not.
      def point_is_inside_poly(poly_verts, point)
        count = poly_verts.count
        intersections = 0

        poly_verts.each_with_index do |face_start, i|
          face_end = poly_verts[(i+1) % count]

          if line_line_intersection(V.new(0, 0), point, face_start, face_end)
            intersections += 1
          end
        end

        !intersections.modulo(2).zero?
      end

      # Returns the position of a line line intersection. Nil if no intersection exists.
      def line_line_intersection(l1s, l1e, l2s, l2e)
        seg1 = l1e - l1s
        seg2 = l2e - l2s

        d = (-seg2.x * seg1.y + seg1.x * seg2.y)

        s = (-seg1.y * (l1s.x - l2s.x) + seg1.x * (l1s.y - l2s.y)) / d;
        t = ( seg2.x * (l1s.y - l2s.y) - seg2.y * (l1s.x - l2s.x)) / d;

        if s > 0 && s < 1 && t > 0 && t < 1
            x = l1s.x + (t * seg1.x)
            y = l1s.y + (t * seg1.y)

            V.new(x, y)
        end
      end

      # Returns the Edge of a poly that intersects a given line. Nil if no intersection exists
      def find_edge_intersecting_with_line(poly_verts, line_start, line_end)
        count = poly_verts.count

        poly_verts.each_with_index do |face_start, i|
          face_end = poly_verts[(i+1) % count]

          contact_loc = line_line_intersection(face_start, face_end, line_start, line_end)

          if contact_loc
            edge = Edge.new(face_start, face_end)
            edge.contact_loc = contact_loc
            return edge
          end
        end

        nil
      end
    end
  end

  VectMath = VectorMath
  VMath = VectorMath
end