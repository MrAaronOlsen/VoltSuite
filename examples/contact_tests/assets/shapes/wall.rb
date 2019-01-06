module Assets
  module Shapes
    class Wall
      attr_reader :start, :term
      attr_reader :shape, :body

      def initialize(pos, start, term)
        @pos = pos
        @start = start
        @term = term

        build

        @color, @z = Canvas::Colors.red, 1
      end

      def build
        @shape = Volt::Shape::Segment.new do |seg|
          seg.build(@start, @term)
        end

        @body = Volt::Body.new do |body|
          body.pos = @pos
          body.add_shape(@shape)
          body.mass = 0
          body.moment = 0
        end

        @body.build
      end

      def update(dt)
      end

      def draw
        Canvas::Pencil.segment(@body.trans.transform(@start), @body.trans.transform(@term), @color.get, @z)
      end
    end
  end
end