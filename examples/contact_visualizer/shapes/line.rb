module GJKShapes
  class Line
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(pos)
      @shape = Volt::Shape::Seg.new do |shape|
        shape.build(V.new(0, 0), V.new(200, 0))
      end

      @body = Body.new do |b|
        b.pos = pos
        b.add_shape(@shape)
      end

      @body.build
      @body.recenter

      @color_off = Canvas::Colors.white
      @color_on = Canvas::Colors.yellow
      @color = @color_off

      @fill = false
      @z = 0

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