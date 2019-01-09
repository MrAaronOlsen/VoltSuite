module Assets
  module Shapes
    class Rect
      attr_reader :shape, :body
      attr_accessor :origin, :width, :height
      attr_accessor :color, :fill, :z
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0

        yield(self)
        build
      end

      def transform_all(points)
        @body.trans.transform_all(points)
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
          body.a_vel = @a_vel
          body.damp = 0.998
        end

        @body.build
        @body.recenter
      end

      def draw
        Canvas::Pencil.rect(transform_all(@shape.verts), @color.get, @fill, @z)
      end
    end
  end
end