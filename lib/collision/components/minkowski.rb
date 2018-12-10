class Minkowski
  attr_reader :support1, :support2

  def initialize(support1, support2)
    @support1, @support2 = support1, support2
  end

  def get_initial_axis
    (@support2.center - @support1.center).normalize
  end

  def get_support(axis)
    point1 = @support1.get_support(axis)
    point2 = @support2.get_support(axis.flip)

    point1 - point2
  end

  def brute
    Array.new.tap do |points|
      @support1.points.each do |point1|
        @support2.points.each do |point2|
          points << point2 - point1
        end
      end
    end
  end
end