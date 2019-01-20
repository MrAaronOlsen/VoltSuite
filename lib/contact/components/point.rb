module Volt
  module Contact
    class Point
      attr_reader :point

      def initialize(point)
        @point = point
      end

      def to_s
        "Point".blue + ": #{@point}"
      end
    end
  end
end