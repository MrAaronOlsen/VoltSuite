module Support
  class Circle
    EPSILON = Epsilon.new.e

    attr_reader :center, :radius
    attr_accessor :resolution

    def initialize(center, radius)
      @center, @radius = center, radius
      @resolution = 10
    end

    def transform(trans)
      @center = trans.transform(@center)
    end

    def get_support(axis)
      (axis.unit * @radius) + @center
    end

    def get_feature(axis)
      Collision::Point.new(get_support(axis))
    end

    def points
      axis = V.new(radius, 0)
      increment = 360 / @resolution

      Array.new.tap do |points|
        increment.times do
          points << (axis + @center)
          axis.rotate!(@resolution)
        end
      end
    end
  end
end