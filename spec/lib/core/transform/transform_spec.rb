RSpec.describe do

  before do
    @shape = [V.new(-1, -1), V.new(1, -1), V.new(1, 1), V.new(-1, 1)]
  end

  it '#transform_vert rotation' do
    rotation = Transform.new_rotate(45)
    @shape.map! { |vert| rotation.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(0.0, -1.4142))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(1.4142, 0.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(0.0, 1.4142))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(-1.4142, 0.0))
  end

  it '#transform_vert scale' do
    scale = Transform.new_scale(2, 2)
    @shape.map! { |vert| scale.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(-2.0, -2.0))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(2.0, -2.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(2.0, 2.0))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(-2.0, 2.0))
  end

  it 'transform_vert translate' do
    translate = Transform.new_translate(V.new(4, 4))

    @shape.map! { |vert| translate.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(3.0, 3.0))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(5.0, 3.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(5.0, 5.0))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(3.0, 5.0))
  end

  it '#transform_vert translate rotate' do
    trans_rot  = Transform.new_transform(V.new(4, 4), 45)

    @shape.map! { |vert| trans_rot.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(4.0, 2.5857))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(5.4142, 4.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(4.0, 5.4142))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(2.5857, 4.0))
  end

  it '#*' do
    translate = Transform.new_translate(V.new(4, 4))
    rotate = Transform.new_rotate(45)

    trans_rot = translate * rotate

    @shape.map! { |vert| trans_rot.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(4.0, 2.5857))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(5.4142, 4.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(4.0, 5.4142))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(2.5857, 4.0))
  end

  it '#multiply' do
    translate = Transform.new_translate(V.new(4, 4))
    rotate = Transform.new_rotate(45)
    translate.multiply(rotate)

    @shape.map! { |vert| translate.transform_vert(vert) }

    expect(@shape[0]).to be_within_vect(0.0001).of(V.new(4.0, 2.5857))
    expect(@shape[1]).to be_within_vect(0.0001).of(V.new(5.4142, 4.0))
    expect(@shape[2]).to be_within_vect(0.0001).of(V.new(4.0, 5.4142))
    expect(@shape[3]).to be_within_vect(0.0001).of(V.new(2.5857, 4.0))
  end

end