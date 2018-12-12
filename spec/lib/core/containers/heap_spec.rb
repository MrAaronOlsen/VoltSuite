RSpec.describe Heap do

  describe "Heap" do

    it "can order in default min priority" do
      heap = Heap.new

      heap.add(30)
      heap.add(10)
      heap.add(15)
      heap.add(50)

      expect(heap.pop).to eq(50)
      expect(heap.pop).to eq(30)
      expect(heap.pop).to eq(15)
      expect(heap.pop).to eq(10)
    end

    it "can order in given priority" do
      heap = Heap.new
      heap.set_comparator { |x, y| x <= y }

      heap.add(30)
      heap.add(10)
      heap.add(15)
      heap.add(50)

      expect(heap.pop).to eq(10)
      expect(heap.pop).to eq(15)
      expect(heap.pop).to eq(30)
      expect(heap.pop).to eq(50)
    end
  end
end