class Epsilon
  attr_reader :e

  def initialize
    @e = compute
  end

  def compute
    e = 0.5

		while 1.0 + e > 1.0 do
			e *= 0.5
    end

		e
  end
end