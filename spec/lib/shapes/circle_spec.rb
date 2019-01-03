RSpec.describe Shape::Circle do

  before do
    @circle = Shape::Circle.new do |shape|
      shape.build(V.new(0, 0), 10)
    end
  end

  it '#builds' do
    verts = @circle.verts

    expect(verts[0]).to eq(V.new(-10, -10))
    expect(verts[1]).to eq(V.new(10, -10))
    expect(verts[2]).to eq(V.new(10, 10))
    expect(verts[3]).to eq(V.new(-10, 10))

    expect(@circle.centroid).to eq(V.new(0, 0))
  end

  it '#transform' do
    trans = Trans.new_transform(V.new(10, 10), 90)
    @circle.transform(trans)

    verts = @circle.verts
    centroid = @circle.centroid

    expect(verts[0]).to eq(V.new(20, 0))
    expect(verts[1]).to eq(V.new(20, 20))
    expect(verts[2]).to eq(V.new(0, 20))
    expect(verts[3]).to eq(V.new(0, 0))

    expect(centroid).to eq(V.new(10, 10))
  end
end