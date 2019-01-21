module Menus
  module Shape
    module Components
      class Circle < Element

        def initialize(pos, color)
          super()

          @pos = pos
          @color = color
          @radius = 40
          @fill = false
        end

        def update(menu)
          has_message("on_hover") ? @fill = true : @fill = false

          if has_messages("on_hover", Gosu::MS_LEFT)
            Message::Queue.add_message(Message.new(menu, self, "spawn_shape", spawn_shape))
          end

          clear_messages
        end

        def spawn_shape
          Assets::Shapes::Generator.new_circle(V.new($window_width - 300, $window_height / 2)).tap do |shape|
            shape.body.vel = V.new(-1000, -200)
          end
        end

        def get_support
          Contact::Support::Circle.new(@pos, @radius)
        end

        def draw
          Canvas::Pencil.circle(@pos, @radius, @color.get, @fill, 1)
        end

        def get_observers
          [Observer::OnHover.new(self), Observer::OnClick.new(Gosu::MS_LEFT, self)]
        end
      end
    end
  end
end