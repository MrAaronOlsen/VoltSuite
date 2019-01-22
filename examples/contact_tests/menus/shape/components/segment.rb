module Menus
  module Shape
    module Components
      class Segment < Element

        def initialize(pos)
          super()

          @trans = Trans.new_translate(pos)
          @leangth = 80

          @color = Canvas::Colors.white
          @color_on = Canvas::Colors.yellow
          @color_off = Canvas::Colors.white

          build
        end

        def build
          @points = @trans.transform_all([V.new(-@leangth / 2, 0), V.new(@leangth / 2, 0)])
          @center = VectMath.average(@points)
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
          Contact::Support::Poly.new(@center, @points)
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