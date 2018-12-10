class Support

  class Circle
    EPSILON = Epsilon.new.e

    attr_reader :center, :radius

    def initialize(center, radius)
      @center, @radius = center, radius
    end

    def get_support(axis)
      (axis.unit * @radius) + @center
    end

    def get_feature(axis)
      Collision::Point.new(get_support(axis))
    end

    def points
      axis = V.new(radius, 0)
      increment = 360 / 10

      Array.new.tap do |points|
        increment.times do
          points << (axis + @center)
          axis.rotate(10)
        end
      end
    end
  end
end