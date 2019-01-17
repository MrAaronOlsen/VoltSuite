module Assets
  module Shapes
    class Segment
      attr_reader :shape, :body
      attr_accessor :pos, :line
      attr_accessor :color, :z, :recenter
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0
        @damp = 0.998
        @recenter = false

        yield(self)
        build
      end

      def transform(point)
        @body.trans.transform(point)
      end

      def build
        @shape = Volt::Shape::Segment.new do |seg|
          seg.build(V.new(0, 0), @line)
        end

        @body = Volt::Body.new do |body|
          body.pos = @pos
          body.add_shape(@shape)
          body.mass = @mass
          body.moment = @moment
          body.vel = @vel
          body.a_vel = @a_vel
          body.damp = @damp
        end

        @body.build
        @body.recenter if @recenter
      end

      def draw
        Canvas::Pencil.segment(transform(@shape.verts[0]), transform(@shape.verts[1]), @color.get, @z)
      end
    end
  end
end