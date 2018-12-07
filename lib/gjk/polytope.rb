class Polytope
  attr_reader :heap

  def initialize
    @heap = Heap.new( lambda { |x, y| x.distance <= y.distance } )
  end

  def add(edge)
    @heap.add(edge)
  end

  def add_all(edges)
    edges.each { |edge| add(edge) }
  end

  def see_closest_edge
    @heap.peek
  end

  def get_closest_edge
    @heap.pop
  end

  def expand(point)
    current_edge = @heap.pop

    point1 = current_edge.start
    point3 = current_edge.terminus

    @heap.add(Edge.new(point1, point))
    @heap.add(Edge.new(point, point3))
  end
end