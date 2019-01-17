module Assets
  module ShapeMenu
    class ShapeMenu

      def initialize(trans)
        @trans = trans

        @border = Border.new(@trans)
      end

      def draw
        @border.draw
      end
    end
  end
end