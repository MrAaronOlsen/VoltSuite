module Volt
  class Shape
    class Poly < Shape

      def initialize
        super(:poly)

        yield self
      end

      def set_verts(verts)
        @verts = verts
      end
    end
  end
end