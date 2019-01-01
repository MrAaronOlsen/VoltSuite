module GJKShapes
  class Line
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(pos)
      @shape = Volt::Shape::Seg.new do |shape|
        shape.set_verts(V.new(0, 0), V.new(200, 0))
      end

      @body = Body.new do |b|
        b.pos = pos
        b.add_shape(@shape)
      end

      @body.init
      @body.recenter

      @color_off = Canvas::Colors.yellow
      @color_on = Canvas::Colors.yellow_green
      @color = @color_off

      @fill = false
      @z = 0



      @active = false
    end

    def pos
      @body.pos
    end

    def rotate(degree)
      @body.rotate(degree)
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
      Canvas::Pencil.line(world_verts, @color.get, @z)
    end

    def mouse_on
      @fill = true
      @color = @color_on
      @z = 2
    end

    def mouse_off
      @fill = false
      @color = @color_off
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