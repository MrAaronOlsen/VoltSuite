module Assets
  module MenuShapes

    class Circle

      def initialize(pos)
        @pos = pos
      end

      def draw
        Canvas::Pencil.circle(@trans.transform(@pos), @radius, @color, @fill, @z)
      end
    end
  end
end