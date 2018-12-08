RSpec.describe Clip do

  it "find contact loc case one" do
    ref = Collision::Edge.new(V.new(5, 3), V.new(5, 7))
    inc = Collision::Edge.new(V.new(6, 6), V.new(6, 2))

    clip = Clip.new
    clip.solve(ref, inc)

    contact_points = clip.contact_points
    expect(contact_points.size).to be(1)

    contact_point = contact_points[0]
    expect(contact_point).to eq(V.new(6, 3))
  end

  it "find contact loc case one" do
    ref = Collision::Edge.new(V.new(4, 7), V.new(7, 4))
    inc = Collision::Edge.new(V.new(6, 2), V.new(6, 6))

    clip = Clip.new
    clip.solve(ref, inc)

    contact_points = clip.contact_points
    expect(contact_points.size).to be(1)

    contact_point = contact_points[0]
    expect(contact_point).to eq(V.new(6, 6))
  end
end