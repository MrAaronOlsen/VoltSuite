module Menus
  module Shape
    module Components
      class Border < Element

        def initialize(trans, width, height)
          super()

          @pos = trans.transform(V.new(0, 0))

          @width = width
          @height = height
          @color_off = Canvas::Colors.white
          @color_on = Canvas::Colors.green

          @points = trans.transform_all([V.new, V.new(width, 0), V.new(width, height), V.new(0, height)])
          @center = VectMath.average(@points)
        end

        def update
          has_message("on_hover") ? @color = @color_on : @color = @color_off

          clear_messages
        end

        def get_support
          Contact::Support::Poly.new(@center, @points)
        end

        def draw
          Canvas::Pencil.rect2(@pos, @width, @height, @color.get, false, 1)
        end

        def get_listeners
          [Listener::OnHover.new(self)]
        end
      end
    end
  end
end