module Volt
  class Shape
    class Rectangle < Shape
      attr_reader :corner, :width, :height

      def initialize
        super(:rect)

        yield self
      end

      def build(corner, width, height)
        @corner = corner
        @width = width
        @height = height

        @verts = Trans.new_translate(@corner).transform_all(get_verts)
        @centroid = VectMath.average(@verts)
      end

      private

      def get_verts
        [ Vect.new(0, 0), Vect.new(@width, 0), Vect.new(@width, @height), Vect.new(0, @height) ]
      end
    end

    Rect = Rectangle
  end
end