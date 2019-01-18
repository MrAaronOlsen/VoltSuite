module Assets
  module ShapeMenu
    class ShapeMenu

      def initialize(trans, color)
        @trans = trans
        @color = color

        @border = Border.new(@trans)
        increment = 800 / 5

        @circle1 = MenuShapes::Circle.new(@trans.transform(V.new(0, -increment * 2)), @color)
        @circle2 = MenuShapes::Circle.new(@trans.transform(V.new(0, -increment)), @color)
        @circle3 = MenuShapes::Circle.new(@trans.transform(V.new(0, 0)), @color)
        @circle4 = MenuShapes::Circle.new(@trans.transform(V.new(0, increment)), @color)
        @circle5 = MenuShapes::Circle.new(@trans.transform(V.new(0, increment * 2)), @color)

        @assets = [@circle1, @circle2, @circle3, @circle4, @circle5, @border]
      end

      def draw
        @assets.each { |asset| asset.draw }
      end
    end
  end
end