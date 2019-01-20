include Contact

RSpec.describe Support::Poly do

  describe 'Without a Transform' do
    before do
      @points = [V.new(2, 2), V.new(4, 1), V.new(6, 2), V.new(4, 4), V.new(2, 3)]
      @support = Support::Poly.new(VectMath.average(@points), @points)
    end

    it '#get_support' do
      expect(@support.get_support(V.new(1, 0))).to eq(V.new(6, 2))
      expect(@support.get_support(V.new(0, 1))).to eq(V.new(4, 4))
      expect(@support.get_support(V.new(-1, 0))).to eq(V.new(2, 2))
      expect(@support.get_support(V.new(0, -1))).to eq(V.new(4, 1))

      expect(@support.get_support(V.new(1, -1))).to eq(V.new(6, 2))
      expect(@support.get_support(V.new(1, 1))).to eq(V.new(6, 2))
      expect(@support.get_support(V.new(-1, 1))).to eq(V.new(2, 3))
      expect(@support.get_support(V.new(-1, -1))).to eq(V.new(2, 2))
    end

    it '#get_feature' do
      feature = @support.get_feature(V.new(1, 0))
      expect(feature.start).to eq(V.new(6, 2))
      expect(feature.terminus).to eq(V.new(4, 4))

      feature = @support.get_feature(V.new(0, 1))
      expect(feature.start).to eq(V.new(4, 4))
      expect(feature.terminus).to eq(V.new(2, 3))

      feature = @support.get_feature(V.new(-1, 0))
      expect(feature.start).to eq(V.new(2, 3))
      expect(feature.terminus).to eq(V.new(2, 2))

      feature = @support.get_feature(V.new(0, -1))
      expect(feature.start).to eq(V.new(4, 1))
      expect(feature.terminus).to eq(V.new(6, 2))
    end

    it '#points' do
      expect(@support.points.size).to eq(5)

      expect(@support.points[0]).to eq(V.new(2, 2))
      expect(@support.points[1]).to eq(V.new(4, 1))
      expect(@support.points[2]).to eq(V.new(6, 2))
      expect(@support.points[3]).to eq(V.new(4, 4))
      expect(@support.points[4]).to eq(V.new(2, 3))
    end
  end

  describe 'With a Transform' do
    before do
      @points = [V.new(2, 2), V.new(4, 1), V.new(6, 2), V.new(4, 4), V.new(2, 3)]
      @support = Support::Poly.new(VectMath.average(@points), @points)

      @trans = Trans.new_transform(V.new(4, 4), 90)
      @support.transform(@trans)
    end

    it '#get_support' do
      expect(@support.get_support(V.new(1, 0))).to eq(@trans.transform(V.new(4, 1)))
      expect(@support.get_support(V.new(0, 1))).to eq(@trans.transform(V.new(6, 2)))
      expect(@support.get_support(V.new(-1, 0))).to eq(@trans.transform(V.new(4, 4)))
      expect(@support.get_support(V.new(0, -1))).to eq(@trans.transform(V.new(2, 2)))

      expect(@support.get_support(V.new(1, -1))).to eq(@trans.transform(V.new(2, 2)))
      expect(@support.get_support(V.new(1, 1))).to eq(@trans.transform(V.new(6, 2)))
      expect(@support.get_support(V.new(-1, 1))).to eq(@trans.transform(V.new(6, 2)))
      expect(@support.get_support(V.new(-1, -1))).to eq(@trans.transform(V.new(2, 3)))
    end

    it '#get_feature' do
      feature = @support.get_feature(V.new(1, 0))
      expect(feature.start).to eq(@trans.transform(V.new(4, 1)))
      expect(feature.terminus).to eq(@trans.transform(V.new(6, 2)))

      feature = @support.get_feature(V.new(0, 1))
      expect(feature.start).to eq(@trans.transform(V.new(6, 2)))
      expect(feature.terminus).to eq(@trans.transform(V.new(4, 4)))

      feature = @support.get_feature(V.new(-1, 0))
      expect(feature.start).to eq(@trans.transform(V.new(4, 4)))
      expect(feature.terminus).to eq(@trans.transform(V.new(2, 3)))

      feature = @support.get_feature(V.new(0, -1))
      expect(feature.start).to eq(@trans.transform(V.new(2, 3)))
      expect(feature.terminus).to eq(@trans.transform(V.new(2, 2)))
    end

    it '#points' do
      expect(@support.points.size).to eq(5)

      expect(@support.points[0]).to eq(@trans.transform(V.new(2, 2)))
      expect(@support.points[1]).to eq(@trans.transform(V.new(4, 1)))
      expect(@support.points[2]).to eq(@trans.transform(V.new(6, 2)))
      expect(@support.points[3]).to eq(@trans.transform(V.new(4, 4)))
      expect(@support.points[4]).to eq(@trans.transform(V.new(2, 3)))
    end
  end
end