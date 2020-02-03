module GJKShapes
  class Tri < GJKShapes::Shape
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(pos)
      super()

      @shape = Volt::Shape::Tri.new do |shape|
        shape.build(V.new(100, 0), V.new(200, 200), V.new(0, 200))
      end

      @body = Body.new do |b|
        b.pos = pos
        b.add_shape(@shape)
      end

      @body.build
      @body.recenter

      @active = false
    end

    def pos
      @body.pos
    end

    def rotate(degree)
      @body.add_angle(degree)
    end

    def get_support
      @shape.get_support.tap { |support| support.transform(@body.trans) }
    end

    def update(mouse)
      @body.pos = mouse.get_mouse_pos - mouse.offset
      @body.set_transform
    end

    def world_verts
      @body.trans.transform_all(@shape.verts)
    end

    def world_center
      @body.trans.transform(@shape.centroid)
    end

    def draw
      Canvas::Pencil.tri(world_verts, @color.get, true, @z)
    end

    def active?
      @active
    end

    def activate
      @active = true
    end

    def deactivate
      @active = false
    end
  end
end