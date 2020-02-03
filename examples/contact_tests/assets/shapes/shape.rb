module Assets
  module Shapes
    class Shape < Element

      def initialize
        super()
        
        @color_on = Canvas::Colors.yellow
        @color_off = Canvas::Colors.white
      end
    end
  end
end
