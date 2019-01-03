RSpec.describe Volt::Shape::Seg do

  before do
    @seg = Shape::Seg.new do |shape|
      shape.build(V.new(-10, 0), V.new(10, 0))
    end
  end

  it '#builds' do
    verts = @seg.verts

    expect(verts[0]).to eq(V.new(-10, 0))
    expect(verts[1]).to eq(V.new(10, 0))

    expect(@seg.centroid).to eq(V.new(0, 0))
  end

  it '#transform' do
    trans = Trans.new_transform(V.new(10, 10), 90)
    @seg.transform(trans)

    verts = @seg.verts
    centroid = @seg.centroid

    expect(verts[0]).to eq(V.new(10, 0))
    expect(verts[1]).to eq(V.new(10, 20))

    expect(centroid).to eq(V.new(10, 10))
  end
end