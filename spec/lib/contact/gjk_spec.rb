include Contact

RSpec.describe GJK do

  describe '#solve simple cases' do
    before do
      points1 = [V.new(2, 1), V.new(3, 3), V.new(1, 3)]
      @support1 = Support::Poly.new(VectMath.average(points1), points1)

      points2 = [V.new(2, 2), V.new(4, 1), V.new(4, 3)]
      @support2 = Support::Poly.new(VectMath.average(points2), points2)

      points3 = [V.new(4, -1), V.new(6, 0), V.new(5, 2), V.new(3, 1)]
      @support3 = Support::Poly.new(VectMath.average(points3), points3)
    end

    it 'case 1' do
      gjk = GJK.new
      mnk = Minkowski.new(@support1, @support2)

      contact = gjk.solve(mnk)
      expect(contact).to be_truthy
    end

    it 'case 2' do
      gjk = GJK.new
      mnk = Minkowski.new(@support2, @support3)

      contact = gjk.solve(mnk)
      expect(contact).to be_truthy
    end

    it 'case 3' do
      gjk = GJK.new
      mnk = Minkowski.new(@support1, @support3)

      contact = gjk.solve(mnk)
      expect(contact).to be_falsey
    end
  end

  describe '#solve edge cases' do
    # Covers the case when an axis passes through the origin.
    it 'degenerate case' do
      points1 = [V.new(6, 5), V.new(9, 5), V.new(9, 8), V.new(6, 8)]
      support1 = Support::Poly.new(VectMath.average(points1), points1)

      points2 = [V.new(8, 5), V.new(11, 5), V.new(11, 8), V.new(8, 8)]
      support2 = Support::Poly.new(VectMath.average(points2), points2)

      gjk = GJK.new
      mnk = Minkowski.new(support1, support2)

      axis = V.new(1, 0)

      simplex = Simplex.new(mnk.get_support(axis))
      simplex.add(mnk.get_support(axis.flip))

      gjk.check_simplex(simplex, axis)
      simplex.add(mnk.get_support(axis))

      expect(gjk.check_simplex(simplex, axis)).to be_truthy
    end

    # Covers the case when one of the faces passes through the origin
    it 'origin border case' do
      points1 = [ V.new(12, 8), V.new(15, 11), V.new(11, 15), V.new(8, 12) ]
      support1 = Support::Poly.new(VectMath.average(points1), points1)

      points2 = [ V.new(4, 16), V.new(4, 13), V.new(10, 13), V.new(10, 16) ]
      support2 = Support::Poly.new(VectMath.average(points2), points2)

      gjk = GJK.new
      mnk = Minkowski.new(support1, support2)

      contact = gjk.solve(mnk)
      expect(contact).to be_truthy
    end
  end
end