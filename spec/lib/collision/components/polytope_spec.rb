RSpec.describe Polytope do

  describe "Polytope" do

    it "can add and pop an edge in priority" do
      polytope = Polytope.new

      polytope.add(third_edge)
      polytope.add(second_edge)
      polytope.add(first_edge)
      polytope.add(fifth_edge)
      polytope.add(fourth_edge)

      heap = polytope.heap

      edge = heap.pop
      expect(edge.start).to eq(first_edge.start)
      expect(edge.terminus).to eq(first_edge.terminus)

      edge = heap.pop
      expect(edge.start).to eq(second_edge.start)
      expect(edge.terminus).to eq(second_edge.terminus)

      edge = heap.pop
      expect(edge.start).to eq(third_edge.start)
      expect(edge.terminus).to eq(third_edge.terminus)

      edge = heap.pop
      expect(edge.start).to eq(fourth_edge.start)
      expect(edge.terminus).to eq(fourth_edge.terminus)

      edge = heap.pop
      expect(edge.start).to eq(fifth_edge.start)
      expect(edge.terminus).to eq(fifth_edge.terminus)
    end
  end

  it "can be built from a simplex" do
    polytope = Polytope.new
    polytope.add_all(simplex.build_edges)

    edge1 = polytope.get_closest_edge
    expect(edge1.start).to eq(V.new(0, -3))
    expect(edge1.terminus).to eq(V.new(2, 3))

    edge2 = polytope.get_closest_edge
    expect(edge2.start).to eq(V.new(2, 3))
    expect(edge2.terminus).to eq(V.new(-3, 0))

    edge3 = polytope.get_closest_edge
    expect(edge3.start).to eq(V.new(-3, 0))
    expect(edge3.terminus).to eq(V.new(0, -3))

    edge4 = polytope.get_closest_edge
    expect(edge4).to be_nil
  end

  it "can expand" do
    polytope = Polytope.new
    polytope.add_all(simplex.build_edges)

    polytope.expand(V.new(5, -3))

    edge1 = polytope.get_closest_edge
    expect(edge1.start).to eq(V.new(2, 3))
    expect(edge1.terminus).to eq(V.new(-3, 0))

    edge2 = polytope.get_closest_edge
    expect(edge2.start).to eq(V.new(-3, 0))
    expect(edge2.terminus).to eq(V.new(0, -3))

    edge3 = polytope.get_closest_edge
    expect(edge3.start).to eq(V.new(0, -3))
    expect(edge3.terminus).to eq(V.new(5, -3))

    edge4 = polytope.get_closest_edge
    expect(edge4.start).to eq(V.new(5, -3))
    expect(edge4.terminus).to eq(V.new(2, 3))

    edge5 = polytope.get_closest_edge
    expect(edge5).to be_nil
  end

  def first_edge
    Collision::Edge.new(V.new(-1, -2), V.new(-2, 1))
  end

  def second_edge
    Collision::Edge.new(V.new(1, -3), V.new(4, 0))
  end

  def third_edge
    Collision::Edge.new(V.new(-2, 5), V.new(3, 2))
  end

  def fourth_edge
    Collision::Edge.new(V.new(-5, -1), V.new(-4, 1))
  end

  def fifth_edge
    Collision::Edge.new(V.new(4, 6), V.new(7, 3))
  end

  def simplex
    Simplex.new(V.new(0, -3)).tap do |simplex|
      simplex.add(V.new(2, 3))
      simplex.add(V.new(-3, 0))
    end
  end
end