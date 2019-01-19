module Assets
  module ShapeMenu
    class Border

      def initialize(trans)
        @pos = trans.transform(V.new(0, 0))

        @width = 150
        @height = 800
        @color = Canvas::Colors.white
      end

      def update
      end

      def draw
        Canvas::Pencil.rect2(@pos, @width, @height, @color.get, false, 1)
      end
    end
  end
end