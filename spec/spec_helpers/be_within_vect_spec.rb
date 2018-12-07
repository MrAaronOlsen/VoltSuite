RSpec.describe BeWithinVect do

  before do
    @vect = V.new(7.0/9.1, 9.0/7.1)
  end

  describe 'Passes Tests' do
    it '#matches by Vector Positive' do
      expect(@vect).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(0.7692, 1.2676))
    end

    it '#matches by Vector Positive' do
      expect(@vect.flip).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(-0.7692, -1.2676))
    end

    it '#matches by Integer Positive' do
      expect(@vect.flip).to be_within_vect(0.0001).of(V.new(-0.7692, -1.2676))
    end

    it '#matches by Integer Positive' do
      expect(@vect.flip).to be_within_vect(0.0001).of(V.new(-0.7692, -1.2676))
    end
  end
end