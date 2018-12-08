RSpec.describe EPA do

  describe '#solve case 1' do
    before do
      points1 = [ V.new(6, 3), V.new(8, 3), V.new(10, 5), V.new(6, 7), V.new(5, 5) ]
      @support1 = Support::Poly.new(VectMath.average(points1), points1)

      points2 = [ V.new(7, 5), V.new(9, 7), V.new(7, 8) ]
      @support2 = Support::Poly.new(VectMath.average(points2), points2)
    end

    it 'first order' do
      gjk = GJK.new
      mnk = Minkowski.new(@support1, @support2)

      contact = gjk.solve(mnk)
      expect(contact).to be_truthy()

      epa = EPA.new
      solution = epa.solve(mnk, gjk.simplex)
      expect(solution).to be_truthy()

      edge = epa.closest_edge
      normal = epa.get_normal
      depth = epa.get_depth

      expect(edge.start).to eq(V.new(3, 0))
      expect(edge.terminus).to eq(V.new(-1, 2))

      expect(normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.4472, 0.8944))

      expect(depth).to be_within(0.0001).of(1.3416)
    end

    it 'reverse order' do
      gjk = GJK.new
      mnk = Minkowski.new(@support2, @support1)

      contact = gjk.solve(mnk)
      expect(contact).to be_truthy()

      epa = EPA.new
      solution = epa.solve(mnk, gjk.simplex)
      expect(solution).to be_truthy()

      edge = epa.closest_edge
      normal = epa.get_normal
      depth = epa.get_depth

      expect(edge.start).to eq(V.new(-3, 0))
      expect(edge.terminus).to eq(V.new(1, -2))

      expect(normal).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.4472, -0.8944))

      expect(depth).to be_within(0.0001).of(1.3416)
    end
  end
end