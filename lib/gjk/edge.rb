class Edge
  attr_reader :start, :terminus

  def initialize(start, terminus)
    @start = start
    @terminus = terminus
  end

  def segment
    @segment ||= @terminus - @start
  end

  def axis
    @axis ||= segment.unit
  end

  def normal
    @normal ||= segment.normal_unit
  end

  def distance
    @distance ||= start.dot(normal).abs
  end

  def to_s
    "Edge".blue + "\n" +
    "Start: #{start}" + "\n" +
    "Terminus: #{terminus}" + "\n" +
    "Normal: #{normal}"
  end

end