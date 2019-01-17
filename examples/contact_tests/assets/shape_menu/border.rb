module Assets
  module ShapeMenu
    class Border

      def initialize(trans)
        @origin = trans.transform(V.new(0, 0))

        @pos = @origin + V.new(-100, -400)
        @width = 200
        @height = 800
        @color = Canvas::Colors.white
      end

      def draw
        Canvas::Pencil.rect2(@pos, @width, @height, @color.get, false, 1)
      end
    end
  end
end