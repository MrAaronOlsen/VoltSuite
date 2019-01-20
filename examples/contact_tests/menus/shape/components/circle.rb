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

        def update
          has_message("on_hover") ? @fill = true : @fill = false
          has_messages("on_hover", Gosu::MS_LEFT) ? @radius = 100 : @radius = 40

          clear_messages
        end

        def get_support
          Contact::Support::Circle.new(@pos, @radius)
        end

        def draw
          Canvas::Pencil.circle(@pos, @radius, @color.get, @fill, 1)
        end

        def get_listeners
          [Listener::OnHover.new(self), Listener::OnClick.new(Gosu::MS_LEFT, self)]
        end
      end
    end
  end
end