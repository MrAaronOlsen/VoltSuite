RSpec.describe Convex do

  describe "Methods" do

    it "find_center" do
      points = [ V.new(10, 10), V.new(20, 10), V.new(20, 20), V.new(10, 20) ]

      convex = Convex.new(points)
      center = convex.find_center(points)

      expect(center).to eq(V.new(15, 15))
    end

    it "Can determine what side a point is on" do
      ref = V.new(4, 6)
      a, b, c, d = V.new(4, 2), V.new(6, 3), V.new(6, 8), V.new(2, 7)

      expect(VectMath.determinant(ref, a, b)).to eq(-1)
      expect(VectMath.determinant(ref, b, c)).to eq(-1)
      expect(VectMath.determinant(ref, c, d)).to eq(-1)
      expect(VectMath.determinant(ref, d, a)).to eq(-1)

      expect(VectMath.determinant(ref, a, d)).to eq(1)
      expect(VectMath.determinant(ref, d, c)).to eq(1)
      expect(VectMath.determinant(ref, c, b)).to eq(1)
      expect(VectMath.determinant(ref, b, a)).to eq(1)

      expect(VectMath.determinant(ref, a, a)).to eq(0)
    end

    it "Can sort points clockwise from upper left" do
      ref = V.new(4, 6)
      points = [ V.new(6, 3), V.new(6, 8), V.new(4, 2), V.new(2, 7) ]

      convex = Convex.new(points)
      sorted_points = convex.sort(points, ref)

      expect(sorted_points[0]).to eq(V.new(4, 2))
      expect(sorted_points[1]).to eq(V.new(6, 3))
      expect(sorted_points[2]).to eq(V.new(6, 8))
      expect(sorted_points[3]).to eq(V.new(2, 7))
    end

    describe '#is_valid invalid cases' do
      it 'empty' do
        convex = Convex.new([])
        expect(convex.is_valid).to be_falsey()
      end

      it '#point' do
        convex = Convex.new([ V.new(5, 2) ])
        expect(convex.is_valid).to be_falsey()
      end

      it 'triangle' do
        convex = Convex.new([ V.new(4, 4), V.new(5, 6), V.new(9, 4) ])
        expect(convex.is_valid).to be_falsey()
      end

      it 'polygon' do
        convex = Convex.new([ V.new(4, 4), V.new(5, 6), V.new(9, 4), V.new(5, 2) ])
        expect(convex.is_valid).to be_falsey()
      end

      it 'polygon not convex' do
        convex = Convex.new([ V.new(4, 4), V.new(5, 6), V.new(6, 4), V.new(9, 4), V.new(5, 2) ])
        expect(convex.is_valid).to be_falsey()
      end
    end

    describe '#is_valid valid cases' do
      it 'line' do
        convex = Convex.new([ V.new(5, 2), V.new(9, 4) ])
        expect(convex.is_valid).to be_truthy()
      end

      it 'triangle' do
        convex = Convex.new([ V.new(5, 2), V.new(9, 4), V.new(5, 6) ])
        expect(convex.is_valid).to be_truthy()
      end

      it 'polygon' do
        convex = Convex.new([ V.new(5, 2), V.new(9, 4), V.new(5, 6), V.new(4, 4)])
        expect(convex.is_valid).to be_truthy()
      end
    end
  end
end