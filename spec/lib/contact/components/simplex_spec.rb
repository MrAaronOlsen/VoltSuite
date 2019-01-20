include Contact

RSpec.describe Simplex do

  describe "Simplex" do

    before do
      @simplex = Simplex.new(V.new(0, -3))
      @simplex.add(V.new(1, -1))
      @simplex.add(V.new(-3, 0))
    end

    it '#get_size' do
      expect(@simplex.get_size).to eq(3)
    end

    it '#get_first' do
      expect(@simplex.get_first).to eq(V.new(0, -3))
    end

    it '#get_second' do
      expect(@simplex.get_second).to eq(V.new(1, -1))
    end

    it '#get_last' do
      expect(@simplex.get_last).to eq(V.new(-3, 0))
    end

    it '#remove' do
      @simplex.remove(1)

      expect(@simplex.get_size()).to eq(2)
      expect(@simplex.get_first).to eq(V.new(0, -3))
      expect(@simplex.get_second).to eq(V.new(-3, 0))
    end

    it '#is_full' do
      expect(@simplex.is_full).to be_truthy()

      @simplex.remove(1)

      expect(@simplex.is_full).to be_falsey()
    end

    it '#get_winding' do
      expect(@simplex.get_winding).to be(-1)

      @simplex.remove(1)
      @simplex.add(V.new(1, -1))

      expect(@simplex.get_winding).to be(1)
    end

    it '#build_edges' do
      edges = @simplex.build_edges

      expect(edges[0].start).to eq(V.new(0, -3))
      expect(edges[0].terminus).to eq(V.new(1, -1))

      expect(edges[1].start).to eq(V.new(1, -1))
      expect(edges[1].terminus).to eq(V.new(-3, 0))

      expect(edges[2].start).to eq(V.new(-3, 0))
      expect(edges[2].terminus).to eq(V.new(0, -3))
    end
  end
end