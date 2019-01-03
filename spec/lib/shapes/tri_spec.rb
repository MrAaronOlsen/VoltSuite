RSpec.describe Volt::Shape::Tri do

  before do
    verts = [V.new(0, -10), V.new(10, 10), V.new(-10, 10)]

    @tri = Shape::Tri.new do |shape|
      shape.build(V.new(0, -10), V.new(10, 10), V.new(-10, 10))
    end
  end

  it '#builds' do
    verts = @tri.verts

    expect(verts[0]).to eq(V.new(0, -10))
    expect(verts[1]).to eq(V.new(10, 10))
    expect(verts[2]).to eq(V.new(-10, 10))

    expect(@tri.centroid).to be_within_vect(0.0001).of(V.new(0, 3.3333))
  end

  it '#transform' do
    trans = Trans.new_transform(V.new(10, 10), 90)
    @tri.transform(trans)

    verts = @tri.verts
    centroid = @tri.centroid

    expect(verts[0]).to eq(V.new(20, 10))
    expect(verts[1]).to eq(V.new(0, 20))
    expect(verts[2]).to eq(V.new(0, 0))

    expect(centroid).to be_within_vect(0.0001).of(V.new(6.6666, 10))
  end
end