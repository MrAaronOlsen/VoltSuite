RSpec.describe Vector do

  describe 'Constructors' do
    it '#new default' do
      vect = Vector.new

      expect(vect.x).to equal(0.0)
      expect(vect.y).to equal(0.0)
    end

    it '#new with parameters' do
      vect = Vector.new(10, 10)

      expect(vect.x).to equal(10.0)
      expect(vect.y).to equal(10.0)
    end

    it '#from_angle' do
      vect = Vector.from_angle(90)

      expect(vect.x).to be_within(0.0001).of(0)
      expect(vect.y).to be_within(0.0001).of(1)
    end

    it '#with_rotation' do
      vect = Vector.with_rotation(1, 0, 90)

      expect(vect.x).to be_within(0.0001).of(0)
      expect(vect.y).to be_within(0.0001).of(1)
    end
  end
end