class Support

  class Circle
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
  end
end