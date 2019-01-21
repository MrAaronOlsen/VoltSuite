module Menus
  module Shape
    class Menu < Element

      def initialize(pos)
        super()

        @pos = pos
        @trans = Trans.new_translate(pos)
        @color = Canvas::Colors.white

        shape_border_height = $window_height - 600
        shape_border_width = 150

        @slot_increment = shape_border_height / 5
        @shape_border = Components::Border.new(@trans, shape_border_width, shape_border_height)

        @circle = Components::Circle.new(slot(0), @color)
        @segment = Components::Segment.new(slot(1), @color)

        @elements = [@circle, @segment, @shape_border]
      end

      def slot(slot)
        @trans.transform(V.new(75, @slot_increment / 2 + (@slot_increment * slot)))
      end

      def update(space)
        @elements.each { |asset| asset.update(self) if !asset.nil? }

        if has_message("spawn_shape")
          message = get_message("spawn_shape")
          message.to = space

          Message::Queue.add_message(message)
        end

        clear_messages
      end

      def get_observers
        @elements.reduce([]) { |sum, element| sum + element.get_observers }
      end

      def draw
        @elements.each { |asset| asset.draw if !asset.nil? }
      end
    end
  end
end