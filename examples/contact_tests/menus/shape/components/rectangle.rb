module Menus
  module Shape
    module Components
      class Rectangle < Element

        def initialize(pos)
          super()

          @trans = Trans.new_translate(pos)
          @width = 80
          @height = 80

          @color = Canvas::Colors.white
          @fill = false

          build
        end

        def build
          @points = [V.new, V.new(@width, 0), V.new(@width, @height), V.new(0, @height)]
          @center = VectMath.average(@points)

          @points = @points.map { |point| @trans.transform(point - @center) }
          @center = @trans.transform(@center)
        end

        def update(menu)
          has_message("on_hover") ? @fill = true : @fill = false

          if has_messages("on_hover", Gosu::MS_LEFT)
            Message::Queue.add_message(Message.new(menu, self, "spawn_shape", spawn_shape))
          end

          clear_messages
        end

        def spawn_shape
          Assets::Shapes::Generator.new_rectangle(V.new($window_width - 300, $window_height / 2)).tap do |shape|
            shape.body.vel = V.new(-1000, -200)
          end
        end

        def get_support
          Contact::Support::Poly.new(@center, @points)
        end

        def draw
          Canvas::Pencil.rect(@points, @color.get, @fill, 1)
        end

        def get_observers
          [Observer::OnHover.new(self), Observer::OnClick.new(Gosu::MS_LEFT, self)]
        end
      end
    end
  end
end