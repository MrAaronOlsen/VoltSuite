module Menus
  module Shape
    class Menu

      def initialize
        @trans = Trans.new_translate(V.new(75, 200))
        @color = Canvas::Colors.white

        @border = Components::Border.new(@trans)
        increment = 800 / 5

        @circle1 = Components::Circle.new(@trans.transform(V.new(75, increment / 2)), @color)
        @circle2 = Components::Circle.new(@trans.transform(V.new(75, increment / 2 + increment)), @color)
        # @circle3 = MenuShapes::Circle.new(@trans.transform(V.new(0, 0)), @color)
        # @circle4 = MenuShapes::Circle.new(@trans.transform(V.new(0, increment)), @color)
        # @circle5 = MenuShapes::Circle.new(@trans.transform(V.new(0, increment * 2)), @color)

        @assets = [@circle1, @circle2, @circle3, @circle4, @circle5, @border]
      end

      def update
        @assets.each { |asset| asset.update if !asset.nil? }
      end

      def get_listeners
        @circle1.get_listeners + @circle2.get_listeners
      end

      def draw
        @assets.each { |asset| asset.draw if !asset.nil? }
      end
    end
  end
end