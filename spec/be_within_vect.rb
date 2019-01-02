module BeWithinVect
  class BeWithinVect

    def initialize(delta)

      if delta.instance_of? Float
        @delta = V.new(delta, delta)
      elsif delta.instance_of? Vector
        @delta = delta
      end
    end

    def of(vect)
      @expected = vect
      @tolerance = @delta

      self
    end

    def matches?(actual)
      @actual = actual

      (@actual.x - @expected.x).abs <= @tolerance.x &&
      (@actual.y - @expected.y).abs <= @tolerance.y
    end

    def failure_message
      "expected #{@actual} to #{description}"
    end

    def description
      "be within #{@delta} of #{@expected}"
    end
  end

  def be_within_vect(vect)
    BeWithinVect.new(vect)
  end
end