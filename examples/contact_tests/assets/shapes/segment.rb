module Assets
  module Shapes
    class Segment
      attr_reader :shape, :body
      attr_accessor :origin, :start, :term
      attr_accessor :color, :z, :recenter
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0
        @recenter = false

        yield(self)
        build
      end

      def transform(point)
        @body.trans.transform(point)
      end

      def build
        @shape = Volt::Shape::Segment.new do |seg|
          seg.build(@start, @term)
        end

        @body = Volt::Body.new do |body|
          body.pos = @origin
          body.add_shape(@shape)
          body.mass = @mass
          body.moment = @moment
          body.vel = @vel
          body.a_vel = @a_vel
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