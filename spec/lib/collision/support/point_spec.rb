RSpec.describe Support::Point do

  before do
    @support = Support::Point.new(V.new(10, 10))
  end

  it '#get_support' do
    expect(@support.get_support(V.new(1, 0))).to (eq(V.new(10, 10)))
    expect(@support.get_support(V.new(0, 1))).to (eq(V.new(10, 10)))
    expect(@support.get_support(V.new(-1, 0))).to (eq(V.new(10, 10)))
    expect(@support.get_support(V.new(0, -1))).to (eq(V.new(10, 10)))
  end

  it '#get_feature' do
    feature = @support.get_feature(V.new(1, 0))
    expect(feature.point).to eq(V.new(10, 10))

    feature = @support.get_feature(V.new(0, 1))
    expect(feature.point).to eq(V.new(10, 10))

    feature = @support.get_feature(V.new(-1, 0))
    expect(feature.point).to eq(V.new(10, 10))

    feature = @support.get_feature(V.new(0, -1))
    expect(feature.point).to eq(V.new(10, 10))
  end

  it '#points' do
    expect(@support.points.size).to eq(1)
    expect(@support.points[0]).to eq(V.new(10, 10))
  end
end