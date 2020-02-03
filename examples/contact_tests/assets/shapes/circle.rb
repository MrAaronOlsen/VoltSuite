module Assets
  module Shapes
    class Circle < Shapes::Shape
      attr_reader :shape, :body
      attr_accessor :origin, :radius
      attr_accessor :color, :fill, :z
      attr_accessor :mass, :moment, :vel, :a_vel

      def initialize
        super()

        @z = 1
        @mass, @moment, @vel, @a_vel = 0, 0, V.new(0, 0), 0
        @damp = 0.998

        yield(self)
        build
      end

      def transform_all(points)
        @body.trans.transform_all(points)
      end

      def build
        @shape = Volt::Shape::Circle.new do |circ|
          circ.build(V.new(0, 0), @radius)
        end

        @body = Body.new do |body|
          body.pos = @origin
          body.add_shape(@shape)
          body.mass = @mass
          body.moment = @moment
          body.vel = @vel
          body.a_vel = @a_vel
          body.damp = @damp
        end

        @body.build
        @body.recenter
      end

      def get_support
        Contact::Support::Circle.new(@body.pos, @shape.radius)
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
        Canvas::Pencil.circle(@body.pos, @shape.radius, @color.get, @fill, @z)
      end
    end
  end
end