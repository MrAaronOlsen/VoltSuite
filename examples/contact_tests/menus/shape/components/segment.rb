module Menus
  module Shape
    module Components
      class Segment < Element

        def initialize(pos, color)
          super()

          @pos = pos
          @color = color
          @leangth = 80

          @color_on = Canvas::Colors.yellow
          @color_off = Canvas::Colors.white
          @color = @color_off

          build
        end

        def build
          @points = [@pos - V.new(@leangth / 2, 0), @pos + V.new(@leangth / 2, 0)]
        end

        def update(menu)
          has_message("on_hover") ? @color = @color_on : @color = @color_off

          if has_messages("on_hover", Gosu::MS_LEFT)
            Message::Queue.add_message(Message.new(menu, self, "spawn_shape", spawn_shape))
          end

          clear_messages
        end

        def spawn_shape
          Assets::Shapes::Generator.new_segment(V.new($window_width - 300, $window_height / 2)).tap do |shape|
            shape.body.vel = V.new(-1000, -200)
          end
        end

        def get_support
          Contact::Support::Poly.new(@pos, @points)
        end

        def draw
          Canvas::Pencil.line(@points, @color.get, 1)
        end

        def get_observers
          [Observer::OnHover.new(self), Observer::OnClick.new(Gosu::MS_LEFT, self)]
        end
      end
    end
  end
end