RSpec.describe Convert do

  it '#radian' do
    expect(Convert.radian(57.3)).to be_within(0.01).of(1.0)
  end

  it '#degree' do
    expect(Convert.degree(1)).to be_within(0.01).of(57.3)
  end
end