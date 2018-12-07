RSpec.describe Vector do
  before do
    @vect1 = Vector.new(3, 4)
    @vect2 = Vector.new(4, 8)
  end

  describe 'Basic Vector Math' do

    it '#+' do
      vect3 = @vect1 + @vect2

      expect(vect3.x).to eq(7.0)
      expect(vect3.y).to eq(12.0)
    end

    it '#add' do
      @vect1.add(Vector.new(5, 6))

      expect(@vect1.x).to eq(8.0)
      expect(@vect1.y).to eq(10.0)
    end

    it '#-' do
      vect3 = @vect1 - @vect2

      expect(vect3.x).to eq(-1.0)
      expect(vect3.y).to eq(-4.0)
    end

    it 'sub' do
      @vect1.sub(Vector.new(5, 6))

      expect(@vect1.x).to eq(-2.0)
      expect(@vect1.y).to eq(-2.0)
    end

    it '#*' do
      vect3 = @vect1 * 2

      expect(vect3.x).to eq(6.0)
      expect(vect3.y).to eq(8.0)
    end

    it '#mult' do
      @vect1.mult(2)

      expect(@vect1.x).to eq(6.0)
      expect(@vect1.y).to eq(8.0)
    end

    it '#/' do
      vect3 = @vect2 / 2

      expect(vect3.x).to eq(2.0)
      expect(vect3.y).to eq(4.0)
    end

    it '#/ zero' do
      vect3 = @vect2 / 0

      expect(vect3.x).to eq(4.0)
      expect(vect3.y).to eq(8.0)
    end

    it '#div' do
      @vect2.div(2)

      expect(@vect2.x).to eq(2.0)
      expect(@vect2.y).to eq(4.0)
    end

    it '#div zero' do
      @vect2.div(0)

      expect(@vect2.x).to eq(4.0)
      expect(@vect2.y).to eq(8.0)
    end

    it '#==' do
      expect(@vect1 == Vector.new(3, 4)).to be_truthy()
    end

    describe "compound math" do
      it 'can do compound math' do
        vect3 = (@vect1 + @vect2) * 10

        expect(vect3.x).to eq(70)
        expect(vect3.y).to eq(120)
      end

      it 'can do compound math' do
        @vect1.add(@vect2).mult(10)

        expect(@vect1.x).to eq(70)
        expect(@vect1.y).to eq(120)
      end
    end

  end
end