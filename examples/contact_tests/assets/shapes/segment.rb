module Assets
  module Shapes
    class Segment < Element
      attr_reader :shape, :body
      attr_accessor :origin, :line
      attr_accessor :color, :z, :recenter
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        super()
        
        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0
        @damp = 0.998
        @recenter = false

        @color_on = Canvas::Colors.yellow
        @color_off = Canvas::Colors.white

        yield(self)
        build
      end

      def transform(point)
        @body.trans.transform(point)
      end

      def build
        @shape = Volt::Shape::Segment.new do |seg|
          seg.build(V.new(0, 0), @line)
        end

        @body = Volt::Body.new do |body|
          body.pos = @origin
          body.add_shape(@shape)
          body.mass = @mass
          body.moment = @moment
          body.vel = @vel
          body.a_vel = @a_vel
          body.damp = @damp
        end

        @body.build
        @body.recenter if @recenter
      end

      def get_support
        verts = @body.trans.transform_all(@body.all_verts)

        Contact::Support::Poly.new(VectMath.average(verts), verts)
      end

      def update(space)
        has_message("on_hover") ? @color = @color_on : @color = @color_off

        if has_messages("on_hover", Gosu::MS_LEFT)
          Message::Queue.add_message(Message.new(space, self, "destroy"))
        end

        clear_messages
      end

      def get_observers
        [Observer::OnHover.new(self), Observer::OnClick.new(Gosu::MS_LEFT, self)]
      end

      def draw
        Canvas::Pencil.segment(transform(@shape.verts[0]), transform(@shape.verts[1]), @color.get, @z)
      end
    end
  end
end