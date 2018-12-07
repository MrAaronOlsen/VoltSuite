RSpec.describe Vector do
  before do
    @vect1 = Vector.new(3, 4)
    @vect2 = Vector.new(4, 8)
  end

  describe 'Advanced Vactor Math' do

    it '#dot' do
      dot = @vect1.dot(@vect2)

      expect(dot).to eq(44.0)
    end

    it '#cross' do
      cross = @vect1.cross(@vect2)

      expect(cross).to eq(8.0)
    end

    it '#cross_z' do
      cross_z = @vect1.cross_z(1.0)

      expect(cross_z.x).to eq(-4)
      expect(cross_z.y).to eq(3)
    end

    it '#cheap_mag' do
      cheap_mag = @vect1.cheap_mag

      expect(cheap_mag).to eq(25.0)
    end

    it '#mag' do
      mag = @vect1.mag

      expect(mag).to eq(5.0)
    end

    it '#normal' do
      normal = @vect1.normal

      expect(normal.x).to eq(-4.0)
      expect(normal.y).to eq(3.0)
    end

    it '#normalize' do
      @vect1.normalize

      expect(@vect1.x).to eq(0.6)
      expect(@vect1.y).to eq(0.8)
    end

    it '#unit' do
      vect = @vect1.unit

      expect(vect.x).to eq(0.6)
      expect(vect.y).to eq(0.8)
    end

    it '#normal_unit' do
      vect = @vect1.normal_unit

      expect(vect.x).to eq(-0.8)
      expect(vect.y).to eq(0.6)
    end
  end
end