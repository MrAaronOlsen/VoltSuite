class GJK
  attr_reader :iterations, :simplex

  EPSILON = Epsilon.e

  def initialize
    @max_iterations = 30
  end

  def solve(minkowski)
    axis = minkowski.get_initial_axis

    @simplex = Simplex.new(minkowski.get_support(axis))

    if VectMath.before_origin(@simplex.get_last, axis)
      return false
    end

    axis.flip!

    @max_iterations.times do
      @simplex.add(minkowski.get_support(axis))

      if VectMath.before_origin(@simplex.get_last, axis)
        return false
      else
        return true if check_simplex(@simplex, axis)
      end
    end
  end

  def check_simplex(simplex, axis)
    a = simplex.get_last
    ao = simplex.get_last * -1

    if simplex.is_full
      ab = simplex.get_second - a
      ac = simplex.get_first - a

      ac_perp = VectMath.normal_towards(ab, ac, ac)

      if ac_perp.dot(ao) >= 0.0
        simplex.remove(1)
        axis.set(ac_perp)
      else
        ab_perp = VectMath.normal_towards(ac, ab, ab)

        if ab_perp.dot(ao) < 0.0
          return true;
        else
          simplex.remove(0)
          axis.set(ab_perp)
        end
      end
    else
      b = simplex.get_first
      ab = b - a

      axis.set(VectMath.normal_towards(ab, ao, ab))

      if axis.cheap_mag <= EPSILON
        axis.set(ab.normal)
      end
    end

    false
  end
end