module Volt
  class Shape
    class Circle < Shape

      def initialize
        super(:circle)

        yield self
      end

      def set_verts(center, radius)
        @radius = radius

        x = center.x
        y = center.y

        @verts = [
          V.new(x - radius, y - radius),
          V.new(x + radius, y - radius),
          V.new(x + radius, y + radius),
          V.new(x - radius, y + radius)
        ]
      end

      def get_support
        Support::Circle.new(@centroid, @radius)
      end
    end
  end
end