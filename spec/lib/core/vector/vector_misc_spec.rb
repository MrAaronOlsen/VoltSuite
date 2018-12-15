RSpec.describe Vector do
  before do
    @vect1 = Vector.new(3, 4)
    @vect2 = Vector.new(4, 8)
  end

  describe 'Misc' do

    it '#zero!' do
      expect(@vect1.x).to eq(3.0)
      expect(@vect1.y).to eq(4.0)

      @vect1.zero!

      expect(@vect1.x).to eq(0.0)
      expect(@vect1.y).to eq(0.0)
    end

    it '#copy' do
      vect3 = @vect1.copy

      expect(vect3.x).to eq(3.0)
      expect(vect3.y).to eq(4.0)

      @vect1.zero!

      expect(@vect1.x).to eq(0.0)
      expect(@vect1.y).to eq(0.0)

      expect(vect3.x).to eq(3.0)
      expect(vect3.y).to eq(4.0)
    end

    it '#set' do
      vect = Vector.new(1, 2)

      expect(vect.x).to eq(1.0)
      expect(vect.y).to eq(2.0)

      vect.set(@vect1)

      expect(vect.x).to eq(3.0)
      expect(vect.y).to eq(4.0)
    end

    it '#flip' do
      vect = @vect1.flip

      expect(vect.x).to eq(-3.0)
      expect(vect.y).to eq(-4.0)
    end

    it '#flip!' do
      @vect1.flip!

      expect(@vect1.x).to eq(-3.0)
      expect(@vect1.y).to eq(-4.0)
    end

    it '#rotate' do
      @vect1.rotate!(90)

      expect(@vect1.x).to be_within(0.0001).of(-4.0)
      expect(@vect1.y).to be_within(0.0001).of(3.0)
    end

    it '#to_s' do
      expect(@vect1.to_s).to eq("X: 3.0, Y: 4.0")
    end

    it '#give_name' do
      @vect1.give_name("Vecty Vect")

      expect(@vect1.to_s).to eq("Vecty Vect | X: 3.0, Y: 4.0")
    end
  end
end