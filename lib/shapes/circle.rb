module Volt
  class Shape
    class Circle < Shape

      def initialize
        super(:circle)

        yield self
      end

      def build(center, radius)
        @radius = radius
        @centroid = center

        @verts = get_verts
      end

      def get_support
        Contact::Support::Circle.new(@centroid, @radius)
      end

    private

      def get_verts
        x = @centroid.x
        y = @centroid.y

        [ V.new(x - @radius, y - @radius),
          V.new(x + @radius, y - @radius),
          V.new(x + @radius, y + @radius),
          V.new(x - @radius, y + @radius) ]
      end
    end

    Circ = Circle
  end
end