module Assets
  module MenuShapes

    class Circle

      def initialize(pos, color)
        @pos = pos
        @color = color
        @radius = 40
      end

      def draw
        Canvas::Pencil.circle(@pos, @radius, @color.get, false, 1)
      end
    end
  end
end