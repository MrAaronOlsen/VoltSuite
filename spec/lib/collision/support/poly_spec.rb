RSpec.describe Support::Poly do

  it '#get_support' do
    points = [V.new(4, 2), V.new(6, 4), V.new(6, 5), V.new(2, 4)]
    support = Support::Poly.new(VectMath.average(points), points)

    expect(support.get_support(V.new(1, 0))).to eq(V.new(6, 4))
    expect(support.get_support(V.new(0, 1))).to eq(V.new(6, 5))
    expect(support.get_support(V.new(-1, 0))).to eq(V.new(2, 4))
    expect(support.get_support(V.new(0, -1))).to eq(V.new(4, 2))

    expect(support.get_support(V.new(1, 1))).to eq(V.new(6, 5))
    expect(support.get_support(V.new(1, -1))).to eq(V.new(4, 2))
    expect(support.get_support(V.new(-1, 1))).to eq(V.new(2, 4))
    expect(support.get_support(V.new(-1, -1))).to eq(V.new(4, 2))
  end

  it '#get_feature' do
    points = [V.new(2, 2), V.new(4, 1), V.new(6, 2), V.new(4, 4), V.new(2, 3)]
    support = Support::Poly.new(VectMath.average(points), points)

    feature = support.get_feature(V.new(1, 0))
    expect(feature.start).to eq(V.new(6, 2))
    expect(feature.terminus).to eq(V.new(4, 4))

    feature = support.get_feature(V.new(0, 1))
    expect(feature.start).to eq(V.new(4, 4))
    expect(feature.terminus).to eq(V.new(2, 3))

    feature = support.get_feature(V.new(-1, 0))
    expect(feature.start).to eq(V.new(2, 3))
    expect(feature.terminus).to eq(V.new(2, 2))

    feature = support.get_feature(V.new(0, -1))
    expect(feature.start).to eq(V.new(4, 1))
    expect(feature.terminus).to eq(V.new(6, 2))
  end
end