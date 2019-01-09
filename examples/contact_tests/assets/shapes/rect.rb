module Assets
  module Shapes
    class Rect
      attr_reader :origin, :width, :height
      attr_reader :shape, :body

      def initialize(origin, width, height)
        @origin = origin
        @width = width
        @height = height

        build

        @color, @fill, @z = Canvas::Colors.blue, true, 1
      end

      def build
        @shape = Volt::Shape::Rect.new do |rect|
          rect.build(@origin, @width, @height)
        end

        @body = Volt::Body.new do |body|
          body.pos = $window_center + V.new(500, 0)
          body.add_shape(@shape)
          body.mass = 10
          body.moment = 500
          body.vel = V.new(-800, -500)
          body.a_vel = -100
          body.damp = 0.998
        end

        @body.build
        @body.recenter
      end

      def update
        
      end

      def draw
        Canvas::Pencil.rect(@body.trans.transform_all(@shape.verts), @color.get, @fill, @z)
      end
    end
  end
end