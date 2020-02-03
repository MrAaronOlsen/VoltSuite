module Menus
  module Shape
    module Components
      class Border < Element

        def initialize(trans, width, height)
          super()

          @pos = trans.transform(V.new(0, 0))

          @width = width
          @height = height
          @background = Assets::Background.new(@pos, @width, @height, Canvas::Color.new(80, 220, 220, 220))
          @color_off = Canvas::Colors.white
          @color_on = Canvas::Colors.light_grey

          @points = trans.transform_all([V.new, V.new(width, 0), V.new(width, height), V.new(0, height)])
          @center = VectMath.average(@points)
        end

        def update(menu)
          has_message("on_hover") ? @color = @color_on : @color = @color_off

          clear_messages
        end

        def get_support
          Contact::Support::Poly.new(@center, @points)
        end

        def draw
          @background.draw
          Canvas::Pencil.rect2(@pos, @width, @height, @color.get, false, 1)
        end

        def get_observers
          [Observer::OnHover.new(self)]
        end
      end
    end
  end
end