module Volt
  module Contact
    class Manifold
      attr_reader :support1, :support2
      attr_reader :reference, :incident
      attr_reader :minkowski, :gjk, :contact, :epa, :clip
      attr_reader :normal, :depth, :points
      attr_reader :restitution
      attr_accessor :body1, :body2

      def initialize(support1, support2)
        @support1, @support2 = support1, support2

        @restitution = 0.8
      end

      def pre_solve
        @minkowski = Minkowski.new(@support1, @support2)

        @gjk = GJK.new
        @contact = @gjk.solve(@minkowski)
      end

      def solve
        @epa = EPA.new
        @epa.solve(@minkowski, @gjk.simplex)

        @depth = @epa.get_depth

        feature1 = @support1.get_feature(@epa.get_normal)
        feature2 = @support2.get_feature(@epa.get_normal.flip)

        if feature1.instance_of? Support::Point
          @reference = @epa.get_closest_edge
          @normal = @epa.get_normal.flip
          @points = [feature1.point]

          return true
        end

        if feature2.instance_of? Support::Point
          @reference = @epa.get_closest_edge
          @normal = @epa.get_normal.flip
          @points = [feature2.point]

          return true
        end

        flipped = false
        @reference, @incident = feature1, feature2

        if @reference.segment.dot(@epa.get_normal).abs > @incident.segment.dot(@epa.get_normal).abs
          @reference, @incident = feature2, feature1

          flipped = true
        end

        @normal = flipped ? @reference.axis.cross_z(1).flip : @reference.axis.cross_z(1)

        @clip = Clip.new
        @clip.solve(@reference, @incident)

        @points = @clip.contact_points
      end

      def contact?
        @contact.nil? ? false : @contact
      end

      def contact_normal
        @normal
      end

      def contact_depth
        @depth
      end

      def contact_points
        @points
      end

    end
  end
end