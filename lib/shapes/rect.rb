module Volt
  class Shape
    class Rect < Shape

      def initialize
        super(:rect)

        yield self
      end

      def set_verts(width, height)
        @verts << Vect.new(0, 0)
        @verts << Vect.new(width, 0)
        @verts << Vect.new(width, height)
        @verts << Vect.new(0, height)
      end
    end
  end
end