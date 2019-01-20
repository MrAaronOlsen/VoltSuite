module Volt
  module Contact
    module Support
      class Point
        attr_reader :point

        def initialize(point)
          @point = point
        end

        def transform(trans)
          @point = trans.transform(@point)
        end

        def get_support(axis)
          point
        end

        def get_feature(axis)
          Point.new(@point)
        end

        def points
          [@point]
        end
      end
    end
  end
end