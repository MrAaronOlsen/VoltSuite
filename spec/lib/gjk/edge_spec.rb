RSpec.describe Edge do

  before do
    @edge = Edge.new(V.new(1, -2), V.new(1, 2))
  end

  it '#segment' do
    expect(@edge.segment).to eq(V.new(0, 4))
  end

  it '#axis' do
    expect(@edge.axis).to eq(V.new(0, 1))
  end

  it '#normal' do
    expect(@edge.normal).to eq(V.new(-1, 0))
  end

  it '#distance' do
    expect(@edge.distance).to eq(1)
  end

end