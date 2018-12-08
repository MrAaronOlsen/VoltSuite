class Convex
  attr_reader :points, :center

  def initialize(points)
    @points = points
  end

  def build
    @center = find_center(@points)
    @points = sort(@points, @center)
  end

  def get_size
    @points.size
  end

  def sort(points, ref)
    points.sort! { |a, b| VectMath.determinant(ref, a, b) }
  end

  def find_center(points)
    VectMath.average(points)
  end

  def is_valid
    size = get_size
    center = find_center(@points)

    # Empty points or single points are not convex shapes
    return false if size <= 1

    # Lines have arbitrary windings making all lines valid
    return true if size == 2

    # Center the shape around the origin
    origin_points = @points.map { |point| point - center }

    origin_points.each.with_index do |point1, i|
      point2 = origin_points[(i + 1) % size]
      this_winding = point2.cross(point1) <=> 0

      # We want all line directions to be counter clockwise
      return false if this_winding != -1
    end
  end
end