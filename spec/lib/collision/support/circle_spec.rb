RSpec.describe Support::Circle do

  it '#get_support' do
    support = Support::Circle.new(V.new(4, 4), 2)

    expect(support.get_support(V.new(1, 0))).to eq(V.new(6, 4))
    expect(support.get_support(V.new(0, 1))).to eq(V.new(4, 6))
    expect(support.get_support(V.new(-1, 0))).to eq(V.new(2, 4))
    expect(support.get_support(V.new(0, -1))).to eq(V.new(4, 2))

    expect(support.get_support(V.new(1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 5.4142))
    expect(support.get_support(V.new(1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(5.4142, 2.5857))
    expect(support.get_support(V.new(-1, 1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 5.4142))
    expect(support.get_support(V.new(-1, -1))).to be_within_vect(V.new(0.0001, 0.0001)).of(V.new(2.5857, 2.5857))
  end

  it '#get_feature' do
    support = Support::Circle.new(V.new(4, 4), 2)

    feature = support.get_feature(V.new(1, 0))
    expect(feature.point).to eq(V.new(6, 4))

    feature = support.get_feature(V.new(0, 1))
    expect(feature.point).to eq(V.new(4, 6))

    feature = support.get_feature(V.new(-1, 0))
    expect(feature.point).to eq(V.new(2, 4))

    feature = support.get_feature(V.new(0, -1))
    expect(feature.point).to eq(V.new(4, 2))
  end

  it '#points' do
    support = Support::Circle.new(V.new(4, 4), 2)
    points = support.points
  end
end