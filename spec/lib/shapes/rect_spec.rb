RSpec.describe Volt::Shape::Rect do

  before do
    @rect = Shape::Rect.new do |shape|
      shape.build(V.new(-10, -10), 20, 20)
    end
  end

  it '#builds' do
    verts = @rect.verts

    expect(verts[0]).to eq(V.new(-10, -10))
    expect(verts[1]).to eq(V.new(10, -10))
    expect(verts[2]).to eq(V.new(10, 10))
    expect(verts[3]).to eq(V.new(-10, 10))

    expect(@rect.centroid).to eq(V.new(0, 0))
  end

  it '#transform' do
    trans = Trans.new_transform(V.new(10, 10), 90)
    @rect.transform(trans)

    verts = @rect.verts
    centroid = @rect.centroid

    expect(verts[0]).to eq(V.new(20, 0))
    expect(verts[1]).to eq(V.new(20, 20))
    expect(verts[2]).to eq(V.new(0, 20))
    expect(verts[3]).to eq(V.new(0, 0))

    expect(centroid).to eq(V.new(10, 10))
  end
end