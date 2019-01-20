module Volt
  module Contact
    class Simplex

      def initialize(a)
        @simplex = [a]
      end

      def add(point)
        @simplex.push(point)
      end

      def remove(index)
        @simplex.delete_at(index)
      end

      def is_full
        get_size == 3
      end

      def get_size
        @simplex.size
      end

      def get_first
        @simplex.first
      end

      def get_second
        @simplex[1]
      end

      def get_last
        @simplex.last
      end

      def build_edges
         size = get_size

        @simplex.map.with_index do |point1, i|
          point2 = @simplex[(i + 1) % size]

          Edge.new(point1, point2)
        end
      end

      def get_winding
        size = get_size

        @simplex.each.with_index do |point1, i|
          point2 = @simplex[(i + 1) % size]

          winding = point2.cross(point1)

          return -1 if winding < 0
          return 1 if winding > 0
        end

        0
      end
    end
  end
end