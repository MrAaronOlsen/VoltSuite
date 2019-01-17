module Assets
  module Shapes
    class Circle
      attr_reader :shape, :body
      attr_accessor :origin, :radius
      attr_accessor :color, :fill, :z
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0
        @damp = 0.998

        yield(self)
        build
      end

      def transform_all(points)
        @body.trans.transform_all(points)
      end

      def build
        @shape = Volt::Shape::Circle.new do |circ|
          circ.build(V.new(0, 0), @radius)
        end

        @body = Volt::Body.new do |body|
          body.pos = @origin
          body.add_shape(@shape)
          body.mass = @mass
          body.moment = @moment
          body.vel = @vel
          body.a_vel = @a_vel
          body.damp = @damp
        end

        @body.build
        @body.recenter
      end

      def draw
        Canvas::Pencil.circle(@body.pos, @shape.radius, @color.get, @fill, @z)
      end
    end
  end
end