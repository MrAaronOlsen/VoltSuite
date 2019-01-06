RSpec.describe Params do
  before do
    @shape1 = Shape::Rect.new do |rect|
      rect.build(V.new(0, 0), 200, 200)
    end

    @body = Body.new do |body|
      body.add_shape(@shape1)
      body.pos = V.new(0, 0)
    end
  end

  describe '#hard_transform' do

    it '#build' do
      @body.build

      expect(@body.pos).to eq(V.new(0, 0))

      trans = @body.trans
      verts = trans.transform_all(@shape1.verts)

      expect(verts[0]).to eq(V.new(0, 0))
      expect(verts[1]).to eq(V.new(200, 0))
      expect(verts[2]).to eq(V.new(200, 200))
      expect(verts[3]).to eq(V.new(0, 200))
    end

    it '#recenter' do
      @body.build
      @body.recenter

      expect(@body.pos).to eq(V.new(0, 0))

      trans = @body.trans
      verts = trans.transform_all(@shape1.verts)

      expect(verts[0]).to eq(V.new(-100, -100))
      expect(verts[1]).to eq(V.new(100, -100))
      expect(verts[2]).to eq(V.new(100, 100))
      expect(verts[3]).to eq(V.new(-100, 100))
    end

    it '#rotate' do
      @body.build
      @body.recenter
      @body.rotate(90)

      expect(@body.pos).to eq(V.new(0, 0))

      trans = @body.trans
      verts = trans.transform_all(@shape1.verts)

      expect(verts[0]).to eq(V.new(100, -100))
      expect(verts[1]).to eq(V.new(100, 100))
      expect(verts[2]).to eq(V.new(-100, 100))
      expect(verts[3]).to eq(V.new(-100, -100))
    end

    it '#offset' do
      @body.build
      @body.offset(V.new(1000, 1000))

      expect(@body.pos).to eq(V.new(0, 0))

      trans = @body.trans
      verts = trans.transform_all(@shape1.verts)

      expect(verts[0]).to eq(V.new(1000, 1000))
      expect(verts[1]).to eq(V.new(1200, 1000))
      expect(verts[2]).to eq(V.new(1200, 1200))
      expect(verts[3]).to eq(V.new(1000, 1200))
    end

    it '#scale' do
      @body.build
      @body.scale(2, 2)

      expect(@body.pos).to eq(V.new(0, 0))

      trans = @body.trans
      verts = trans.transform_all(@shape1.verts)

      expect(verts[0]).to eq(V.new(0, 0))
      expect(verts[1]).to eq(V.new(400, 0))
      expect(verts[2]).to eq(V.new(400, 400))
      expect(verts[3]).to eq(V.new(0, 400))
    end
  end
end