module Volt
  module Contact
    class LineLine
      attr_reader :manifold

      def initialize(line1, line2)
        @line1, @line2 = line1, line2
      end

      def query
        line1_start = @line1.body.trans.transform(@line1.verts[0])
        line1_end = @line1.body.trans.transform(@line1.verts[1])

        line2_start = @line2.body.trans.transform(@line2.verts[0])
        line2_end = @line2.body.trans.transform(@line2.verts[1])

        contact_loc = VectMath.line_line_intersection(line1_start, line1_end, line2_start, line2_end)

        return false unless contact_loc

        seg1 = line1_start - line1_end
        seg2 = line2_start - line2_end

        l1_point = VectMath.closest_point_to_line([line1_start, line1_end], line2_start, line2_end)
        l2_point = VectMath.closest_point_to_line([line2_start, line2_end], line1_start, line1_end)

        if l1_point.distance < l2_point.distance
          @manifold = Manifold.new do |man|
            man.penetration = l1_point.distance
            man.contact_normal = seg2.normal.unit
            man.contact_loc = contact_loc
          end
        else
          @manifold = Manifold.new do |man|
            man.penetration = l2_point.distance
            man.contact_normal = seg1.normal.unit
            man.contact_loc = contact_loc
          end
        end

        d = VectMath.average([line1_start, line1_end]) - VectMath.average([line2_start, line2_end])
        @manifold.flip_normal if d.dot(@manifold.contact_normal) < 0

        return true
      end

      def manifold
        @manifold.tap do |man|
          man.add_bodies(@line1.body, @line2.body)
        end
      end
    end
  end
end