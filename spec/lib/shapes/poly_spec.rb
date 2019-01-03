RSpec.describe Volt::Shape::Poly do

  before do
    @poly = Shape::Poly.new do |shape|
      shape.build([V.new(-10, -10), V.new(10, -10), V.new(10, 10), V.new(-10, 10)])
    end
  end

  it '#builds' do
    verts = @poly.verts

    expect(verts[0]).to eq(V.new(-10, -10))
    expect(verts[1]).to eq(V.new(10, -10))
    expect(verts[2]).to eq(V.new(10, 10))
    expect(verts[3]).to eq(V.new(-10, 10))

    expect(@poly.centroid).to eq(V.new(0, 0))
  end

  it '#transform' do
    trans = Trans.new_transform(V.new(10, 10), 90)
    @poly.transform(trans)

    verts = @poly.verts
    centroid = @poly.centroid

    expect(verts[0]).to eq(V.new(20, 0))
    expect(verts[1]).to eq(V.new(20, 20))
    expect(verts[2]).to eq(V.new(0, 20))
    expect(verts[3]).to eq(V.new(0, 0))

    expect(centroid).to eq(V.new(10, 10))
  end
end