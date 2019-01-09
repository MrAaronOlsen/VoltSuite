module GJKShapes
  class Tri
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(pos)
      @shape = Volt::Shape::Tri.new do |shape|
        shape.build(V.new(100, 0), V.new(200, 200), V.new(0, 200))
      end

      @body = Body.new do |b|
        b.pos = pos
        b.add_shape(@shape)
      end

      @body.build
      @body.recenter

      @color = Canvas::Colors.green
      @fill = false
      @z = 1

      @active = false
    end

    def pos
      @body.pos
    end

    def rotate(degree)
      @body.add_angle(degree)
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

    def get_support
      Support::Poly.new(world_center, world_verts)
    end

    def draw
      Canvas::Pencil.tri(world_verts, @color.get, @fill, @z)
    end

    def mouse_on
      @fill = true
      @z = 2
    end

    def mouse_off
      @fill = false
      @z = 1
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