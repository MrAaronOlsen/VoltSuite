module GJKShapes
  class Poly < GJKShapes::Shape
    attr_reader :shape, :body, :active
    attr_accessor :color, :fill, :z

    def initialize(pos)
      super()

      @shape = Volt::Shape::Poly.new do |shape|
        shape.build(Poly.make_poly(@width / 2, rand(5..12)))
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
      Canvas::Pencil.poly(world_verts, world_center, @color.get, true, @z)
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

    class << self
      def make_poly(radius, num_points)
        angle = 360 / num_points
        axis = Vector.new(0, -radius)

        Array.new.tap do |a|
          num_points.times do |i|
            axis.rotate!(angle)
            a.push(axis.copy)
          end
        end
      end
    end
  end
end