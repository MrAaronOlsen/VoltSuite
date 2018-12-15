RSpec.describe Support::Circle do

  describe 'Without A Transform' do
    before do
      @support = Support::Circle.new(V.new(4, 4), 2)
    end

    it '#get_support' do
      expect(@support.get_support(V.new(1, 0))).to eq(V.new(6, 4))
      expect(@support.get_support(V.new(0, 1))).to eq(V.new(4, 6))
      expect(@support.get_support(V.new(-1, 0))).to eq(V.new(2, 4))
      expect(@support.get_support(V.new(0, -1))).to eq(V.new(4, 2))

      expect(@support.get_support(V.new(1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 5.4142))
      expect(@support.get_support(V.new(1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 2.5857))
      expect(@support.get_support(V.new(-1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 5.4142))
      expect(@support.get_support(V.new(-1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 2.5857))
    end

    it '#get_feature' do
      feature = @support.get_feature(V.new(1, 0))
      expect(feature.point).to eq(V.new(6, 4))

      feature = @support.get_feature(V.new(0, 1))
      expect(feature.point).to eq(V.new(4, 6))

      feature = @support.get_feature(V.new(-1, 0))
      expect(feature.point).to eq(V.new(2, 4))

      feature = @support.get_feature(V.new(0, -1))
      expect(feature.point).to eq(V.new(4, 2))
    end

    it '#points' do
      # Resolution is defaulted to 10
      @support.resolution = 10
      points = @support.points

      # This gives us 36 points out of 360 degrees
      expect(points.size).to eq(36)

      axis = V.new(@support.radius)
      center = @support.center

      # We can test the points by rotating our axis by index * resolution
      points.each_with_index do |point, i|
        expect(point).to be_within_vect(0.0001).of(axis.rotate(i * 10) + center)
      end
    end
  end

  describe 'With A Transform' do
    before do
      @support = Support::Circle.new(V.new, 2)

      # Because testing a circle is a little funky, we're just setting the circle's center at origin and translating
      # it to the previous test so we can use those values. Rotation is here, but is irrelavent.
      @trans = Trans.new_transform(V.new(4, 4), 90)
      @support.transform(@trans)
    end

    it '#get_support' do
      expect(@support.get_support(V.new(1, 0))).to eq(V.new(6, 4))
      expect(@support.get_support(V.new(0, 1))).to eq(V.new(4, 6))
      expect(@support.get_support(V.new(-1, 0))).to eq(V.new(2, 4))
      expect(@support.get_support(V.new(0, -1))).to eq(V.new(4, 2))

      expect(@support.get_support(V.new(1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 5.4142))
      expect(@support.get_support(V.new(1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 2.5857))
      expect(@support.get_support(V.new(-1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 5.4142))
      expect(@support.get_support(V.new(-1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 2.5857))
    end

    it '#get_feature' do
      feature = @support.get_feature(V.new(1, 0))
      expect(feature.point).to eq(V.new(6, 4))

      feature = @support.get_feature(V.new(0, 1))
      expect(feature.point).to eq(V.new(4, 6))

      feature = @support.get_feature(V.new(-1, 0))
      expect(feature.point).to eq(V.new(2, 4))

      feature = @support.get_feature(V.new(0, -1))
      expect(feature.point).to eq(V.new(4, 2))
    end

    it '#points' do
      # Resolution is defaulted to 10
      @support.resolution = 10
      points = @support.points

      # This gives us 36 points out of 360 degrees
      expect(points.size).to eq(36)

      axis = V.new(@support.radius)
      center = @support.center

      # We can test the points by rotating our axis by index * resolution
      points.each_with_index do |point, i|
        expect(point).to be_within_vect(0.0001).of(axis.rotate(i * 10) + center)
      end
    end
  end
end