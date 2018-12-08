RSpec.describe Minkowski do

  before do
    points1 = [V.new(2, 1), V.new(3, 3), V.new(1, 3)]
    @support1 = Support::Poly.new(VectMath.average(points1), points1)

    points2 = [V.new(2, 2), V.new(4, 1), V.new(5, 3)]
    @support2 = Support::Poly.new(VectMath.average(points2), points2)

    @support3 = Support::Circle.new(V.new(6, 4), 2)
    @support4 = Support::Circle.new(V.new(6, 8), 3)
  end

  describe 'Poly Poly' do

    it '#get_initial_axis' do
      mnk = Minkowski.new(@support1, @support2)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.9805, -0.1961))
    end

    it '#get_support' do
      mnk = Minkowski.new(@support1, @support2)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff).to eq(V.new(1.0, 1.0))
    end

    it '#get_initial_axis reverse' do
      mnk = Minkowski.new(@support2, @support1)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.9805, 0.1961))
    end

    it '#get_support reverse' do
      mnk = Minkowski.new(@support2, @support1)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff.x).to eq(-1.0)
      expect(diff.y).to eq(-1.0)
    end
  end

  describe 'Circle Circle' do

    it '#get_initial_axis' do
      mnk = Minkowski.new(@support3, @support4)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.0, 1.0))
    end

    it '#get_support' do
      mnk = Minkowski.new(@support3, @support4)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.0, 1.0))
    end

    it '#get_initial_axis reverse' do
      mnk = Minkowski.new(@support4, @support3)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.0, -1.0))
    end

    it '#get_support reverse' do
      mnk = Minkowski.new(@support4, @support3)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.0, -1.0))
    end
  end

  describe 'Poly Circle' do

    it '#get_initial_axis' do
      mnk = Minkowski.new(@support2, @support3)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.7592, 0.6507))
    end

    it '#get_support' do
      mnk = Minkowski.new(@support2, @support3)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.5185, 0.3015))
    end

    it '#get_initial_axis reverse' do
      mnk = Minkowski.new(@support3, @support2)
      axis = mnk.get_initial_axis

      expect(axis).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.7592, -0.6507))
    end

    it '#get_support reverse' do
      mnk = Minkowski.new(@support3, @support2)

      axis = mnk.get_initial_axis
      diff = mnk.get_support(axis)

      expect(diff).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.5185, -0.3015))
    end
  end
end