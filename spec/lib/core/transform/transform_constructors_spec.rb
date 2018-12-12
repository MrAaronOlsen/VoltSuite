RSpec.describe Transform do

  it '#new_identity' do
    trans = Transform.new_identity

    expect(trans.a).to eq(1)
    expect(trans.b).to eq(0)
    expect(trans.c).to eq(0)
    expect(trans.d).to eq(1)
    expect(trans.tx).to eq(0)
    expect(trans.ty).to eq(0)
  end

  it '#new_translate' do
    trans = Transform.new_translate(V.new(11, 13))

    expect(trans.a).to eq(1)
    expect(trans.b).to eq(0)
    expect(trans.c).to eq(0)
    expect(trans.d).to eq(1)
    expect(trans.tx).to eq(11)
    expect(trans.ty).to eq(13)
  end

  it '#new_rotate' do
    trans = Transform.new_rotate(180)

    expect(trans.a).to eq(-1)
    expect(trans.b).to be_within(0.0001).of(0.0)
    expect(trans.c).to be_within(0.0001).of(0.0)
    expect(trans.d).to eq(-1)
    expect(trans.tx).to eq(0)
    expect(trans.ty).to eq(0)
  end

  it '#new_transform' do
    trans = Transform.new_transform(V.new(11, 13), 180)

    expect(trans.a).to eq(-1)
    expect(trans.b).to be_within(0.0001).of(0.0)
    expect(trans.c).to be_within(0.0001).of(0.0)
    expect(trans.d).to eq(-1)
    expect(trans.tx).to eq(11)
    expect(trans.ty).to eq(13)
  end
end