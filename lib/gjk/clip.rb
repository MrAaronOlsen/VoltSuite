class Clip
  attr_reader :contact_points

  def initialize
    @contact_points = Array.new
  end

  def solve(ref, inc)

    o1 = ref.segment.dot(ref.start)
    @contact_points = clip(inc.start, inc.terminus, ref.segment, o1)

    return if @contact_points.length < 2

    # clip whats left of the incident edge by the second vertex of the reference edge
    # but we need to clip in the opposite direction so we flip the direction and offset
    o2 = ref.segment.dot(ref.terminus);
    @contact_points = clip(@contact_points[0], @contact_points[1], ref.segment * -1, o2 * -1)

    # if we dont have 2 points left then fail
    return if @contact_points.length < 2

    # get the reference edge normal
    refNorm = ref.normal

    # get the largest depth
    max = refNorm.dot(ref.start)

    # make sure the final points are not past this maximum
    depth1 = refNorm.dot(@contact_points[0]) - max
    depth2 = refNorm.dot(@contact_points[1]) - max

    @contact_points.delete_at(0) if depth1 < 0.0
    @contact_points.delete_at(1) if depth2 < 0.0
  end

  def clip(v1, v2, n, o)
    Array.new.tap do |cp|
      d1 = n.dot(v1) - o;
      d2 = n.dot(v2) - o;

      # if either point is past o along n then we can keep the point
      cp.push(v1) if (d1 >= 0.0)
      cp.push(v2) if (d2 >= 0.0)

      # finally we need to check if they are on opposing sides so that we can compute the correct point
      if d1 * d2 < 0.0
        # if they are on different sides of the offset, d1 and d2 will be a (+) * (-)
        # and will yield a (-) and therefore be less than zero get the vector for the edge we are clipping
        e = v2 - v1
        # compute the location along e
        u = d1 / (d1 - d2)
        e.mult(u)
        e.add(v1)
        # add the point
        cp.push(e)
      end
    end
  end
end